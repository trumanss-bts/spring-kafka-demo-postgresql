package org.example.testproject.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.testproject.dto.*;
import org.example.testproject.entity.Task;
import org.example.testproject.entity.TaskStatus;
import org.example.testproject.entity.User;
import org.example.testproject.event.TaskEvent;
import org.example.testproject.repository.TaskRepository;
import org.example.testproject.repository.UserRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Slf4j
public class TaskService {
    private final TaskRepository taskRepository;
    private final UserRepository userRepository;
    private final KafkaEventService kafkaService;
    
    public Page<TaskResponse> getAllTasks(Pageable pageable) {
        return taskRepository.findAll(pageable).map(this::toResponse);
    }
    
    public TaskResponse getTaskById(Long id) {
        Task task = taskRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Task not found: " + id));
        return toResponse(task);
    }
    
    @Transactional
    public TaskResponse createTask(TaskRequest request) {
        Task task = new Task();
        task.setName(request.getName());
        task.setDescription(request.getDescription());
        task.setStatus(TaskStatus.PENDING);
        
        Task saved = taskRepository.save(task);
        
        TaskEvent event = new TaskEvent();
        event.setEventType("TASK_CREATED");
        event.setTaskId(saved.getId());
        event.setTaskName(saved.getName());
        kafkaService.sendEvent(event);
        
        log.info("Задача создана: {}", saved.getId());
        return toResponse(saved);
    }
    
    @Transactional
    public TaskResponse assignExecutor(Long taskId, AssignExecutorRequest request) {
        Task task = taskRepository.findById(taskId)
            .orElseThrow(() -> new RuntimeException("Task not found: " + taskId));
        
        User executor = userRepository.findById(request.getExecutorId())
            .orElseThrow(() -> new RuntimeException("User not found: " + request.getExecutorId()));
        
        task.setExecutor(executor);
        Task updated = taskRepository.save(task);
        
        TaskEvent event = new TaskEvent();
        event.setEventType("EXECUTOR_ASSIGNED");
        event.setTaskId(updated.getId());
        event.setTaskName(updated.getName());
        event.setExecutorId(executor.getId());
        event.setExecutorName(executor.getName());
        kafkaService.sendEvent(event);
        
        log.info("Назначен исполнитель для задачи: {}", taskId);
        return toResponse(updated);
    }
    
    @Transactional
    public TaskResponse changeStatus(Long taskId, StatusUpdateRequest request) {
        Task task = taskRepository.findById(taskId)
            .orElseThrow(() -> new RuntimeException("Task not found: " + taskId));
        
        TaskStatus oldStatus = task.getStatus();
        task.setStatus(request.getStatus());
        Task updated = taskRepository.save(task);
        
        TaskEvent event = new TaskEvent();
        event.setEventType("STATUS_CHANGED");
        event.setTaskId(updated.getId());
        event.setTaskName(updated.getName());
        event.setOldStatus(oldStatus.name());
        event.setNewStatus(request.getStatus().name());
        kafkaService.sendEvent(event);
        
        log.info("Статус задачи {} изменен с {} на {}", taskId, oldStatus, request.getStatus());
        return toResponse(updated);
    }
    
    private TaskResponse toResponse(Task task) {
        TaskResponse response = new TaskResponse();
        response.setId(task.getId());
        response.setName(task.getName());
        response.setDescription(task.getDescription());
        response.setStatus(task.getStatus());
        response.setCreatedAt(task.getCreatedAt());
        

        return response;
    }
}
