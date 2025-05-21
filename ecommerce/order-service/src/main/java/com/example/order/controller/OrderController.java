package com.example.order.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import com.example.order.client.ProductClient;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class OrderController {
    private final ProductClient productClient;

    public OrderController(ProductClient productClient) {
        this.productClient = productClient;
    }

    @GetMapping("/orders/forward")
    public String callProduct() {
        return "Order calls: " + productClient.hello();
    }
}
