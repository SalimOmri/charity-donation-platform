package com.backend.charity.Exception;

public class ExpiredTokenException extends RuntimeException {
    public ExpiredTokenException(String message) {

        super(message);
    }
}
