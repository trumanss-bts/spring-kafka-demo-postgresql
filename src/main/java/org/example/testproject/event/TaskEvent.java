package org.example.testproject.event;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TaskEvent {
    private String eventType;
    private Long taskId;
    private String taskName;
    private Long executorId;
    private String executorName;
    private String oldStatus;
    private String newStatus;
}
