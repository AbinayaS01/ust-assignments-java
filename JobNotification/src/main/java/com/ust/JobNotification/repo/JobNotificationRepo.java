package com.ust.JobNotification.repo;

import com.ust.JobNotification.model.JobNotificationInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface JobNotificationRepo extends JpaRepository<JobNotificationInfo,Long> {
}
