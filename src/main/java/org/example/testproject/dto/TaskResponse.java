package org.example.testproject.dto;


import org.example.testproject.entity.TaskStatus;
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class TaskResponse {
    private Long id;
    private String name;
    private String description;
    private TaskStatus status;
    private UserDto executor;
    private LocalDateTime createdAt;

    @Data
    public static class UserDto {
        private Long id;
        private String name;
        private String email;
    }
}
