package org.example.testproject.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class AssignExecutorRequest {
    @NotNull(message = "ID исполнителя обязателен")
    private Long executorId;
}