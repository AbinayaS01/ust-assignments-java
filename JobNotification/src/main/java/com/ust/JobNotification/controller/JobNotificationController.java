package com.ust.JobNotification.controller;

import com.ust.JobNotification.model.JobNotificationInfo;
import com.ust.JobNotification.service.JobNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/ust")

public class JobNotificationController {
    @Autowired
    private JobNotificationService service;
    @PostMapping("/addJob")
    public JobNotificationInfo addJob(@RequestBody JobNotificationInfo info){
        return service.addJob(info);
    }

    @GetMapping("/getJob")
    public List<JobNotificationInfo> getJob(){
        return service.getJob();
    }
   @GetMapping("/getJob/{id}")
    public JobNotificationInfo getJobByID(@PathVariable Long id){
        return service.getJobByID(id);
   }
}
