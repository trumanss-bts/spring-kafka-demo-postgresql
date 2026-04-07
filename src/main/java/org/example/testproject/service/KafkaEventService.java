package org.example.testproject.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.testproject.event.TaskEvent;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class KafkaEventService {
    private final KafkaTemplate<String, TaskEvent> kafkaTemplate;
    private final String TOPIC = "task-events";
    
    public void sendEvent(TaskEvent event) {
        kafkaTemplate.send(TOPIC, event.getTaskId().toString(), event);
        log.info("Событие отправлено в Kafka: {}", event);
    }
}
