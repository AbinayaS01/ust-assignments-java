package com.ust.JobNotification.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name="JobNotificationInfo")
public class JobNotificationInfo {
    //jobId, jobTitle, description, location, and salary
    @Id
    private Long jobId;
    private String jobTitle;
    private String description;
    private String location;
    private double salary;

}
