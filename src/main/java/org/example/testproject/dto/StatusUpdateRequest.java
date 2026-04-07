package org.example.testproject.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.example.testproject.entity.TaskStatus;

@Data
public class StatusUpdateRequest {
    @NotNull(message = "Статус обязателен")
    private TaskStatus status;
}
