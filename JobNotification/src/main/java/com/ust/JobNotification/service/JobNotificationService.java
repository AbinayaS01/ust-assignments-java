package com.ust.JobNotification.service;

import com.ust.JobNotification.model.JobNotificationInfo;
import com.ust.JobNotification.repo.JobNotificationRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class JobNotificationService {
    @Autowired
    private JobNotificationRepo repo;
    public JobNotificationInfo addJob(JobNotificationInfo info){
        return repo.save(info);
    }


    public List<JobNotificationInfo> getJob(){
        return repo.findAll();
    }
    public JobNotificationInfo getJobByID(Long id){
        return repo.findById(id).orElse(null);
    }
}
