需求简化版：用户下单、支付、发货。单一卖家（平台管理员）管理订单。
支付全部可以以接口调用形式，或者模拟支付平台回调的方式完成。

用户在平台下单后，系统创建订单记录，初始状态为 PENDING。

用户发起支付请求，系统生成对应支付记录，支付成功后，自动将订单状态更新为 PAID。

Admin（平台管理员，唯一卖家）可查看所有订单列表，并在用户支付成功后进行发货处理。

系统提供接口供用户或平台查询订单与支付状态，整个流程实现从下单到发货的闭环。

所有数据通过数据库表（orders、payments、users）结构化管理，便于扩展与审计。


[1] 用户提交订单请求
    └── POST /orders
    └── 返回：订单ID, totalPrice, status=PENDING
           ↓

[2] 用户点击“立即支付”
    └── POST /payments
    └── 参数：orderId, userId, method (wechat/alipay)
    └── 返回：paymentId, status=PENDING
           ↓

[3] 用户完成支付（或支付平台回调）
    └── POST /payments/{paymentId}/confirm
    └── 更新：status → SUCCESS, 记录 paidAt, transactionNo
    └── 同时：orders.status → PAID
           ↓

[4] 用户或系统查询订单/支付状态
    └── GET /orders/{orderId}
    └── GET /payments/{paymentId}

API 设计

1. 提交订单
   - **请求**：`POST /orders`
   - **参数**：
     - `userId`: 用户ID
     - `items`: 商品列表（包含商品ID和数量）
   - **返回**：
     - `orderId`: 订单ID
     - `totalPrice`: 总价
     - `status`: 订单状态（PENDING）
2. 创建支付
    - **请求**：`POST /payments`
    - **参数**：
      - `orderId`: 订单ID
      - `userId`: 用户ID
      - `method`: 支付方式（wechat/alipay）
    - **返回**：
      - `paymentId`: 支付ID
      - `status`: 支付状态（PENDING）
3. 确认支付
    - **请求**：`POST /payments/{paymentId}/confirm`
    - **参数**：
      - `paymentId`: 支付ID
      - `status`: 支付状态（SUCCESS）
      - `paidAt`: 支付时间
      - `transactionNo`: 交易号
    - **返回**：
      - 更新支付状态和订单状态 
4. 查询订单状态
    - **请求**：`GET /orders/{orderId}`
    - **参数**：
      - `orderId`: 订单ID
    - **返回**：
      - `orderId`: 订单ID
      - `userId`: 用户ID
      - `status`: 订单状态
      - `totalPrice`: 总价
      - `createdAt`: 创建时间
5. 查询支付状态
    - **请求**：`GET /payments/{paymentId}`
    - **参数**：
      - `paymentId`: 支付ID
    - **返回**：
      - `paymentId`: 支付ID
      - `orderId`: 订单ID
      - `userId`: 用户ID
      - `status`: 支付状态
      - `method`: 支付方式
      - `paidAt`: 支付时间
      - `transactionNo`: 交易号 

user 表设计
```sql
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255), -- 可先不实现登录逻辑
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
order 表设计
```sql
CREATE TABLE orders (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,     -- orderId
    user_id BIGINT NOT NULL,                  -- 下单用户
    total_price DECIMAL(10,2) NOT NULL,       -- 总价
    status ENUM('PENDING', 'PAID', 'SHIPPED', 'CANCELLED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
payment 表设计
```sql
CREATE TABLE payments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,      -- paymentId
    order_id BIGINT NOT NULL,                  -- 关联订单
    user_id BIGINT NOT NULL,                   -- 支付用户
    method ENUM('WECHAT', 'ALIPAY') NOT NULL,  -- 支付方式
    status ENUM('PENDING', 'SUCCESS', 'FAILED') DEFAULT 'PENDING',
    paid_at TIMESTAMP,
    transaction_no VARCHAR(100),                -- 第三方支付平台交易号
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
