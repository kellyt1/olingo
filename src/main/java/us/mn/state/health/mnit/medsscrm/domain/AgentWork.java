package us.mn.state.health.mnit.medsscrm.domain;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
@Table(name = "agent_work")
@Data
public class AgentWork {

    @Id
    @Column(name = "id")
    private String id;

    @Column(name = "accept_datetime")
    private Date acceptDatetime;

    @Column(name = "agent_work_name")
    private String agentWorkName;

    @Column(name = "assigned_datetime")
    private Date assignedDatetime;

    @Column(name = "cancel_datetime")
    private Date cancelDatetime;

    @Column(name = "close_datetime")
    private Date closeDatetime;

    @Column(name = "company")
    private String company;

    @Column(name = "county")
    private String county;

    @Column(name = "decline_datetime")
    private Date declineDatetime;

    @Column(name = "handle_time")
    private Long handleTime;

    @Column(name = "is_owner_change_initiated")
    private Boolean isOwnerChangeInitiated;

    @Column(name = "is_status_change_initiated")
    private Boolean isStatusChangeInitiated;

    @Column(name = "medss_event_id")
    private String medssEventId;

    @Column(name = "medss_event_name")
    private String medssEventName;

    @Column(name = "medss_event_record_type")
    private String medssEventRecordType;

    @Column(name = "medss_event_status")
    private String medssEventStatus;

    @Column(name = "mn_id")
    private String mnId;

    @Column(name = "original_group_name")
    private String originalGroupName;

    @Column(name = "original_queue_name")
    private String originalQueueName;

    @Column(name = "owner_name")
    private String ownerName;

    @Column(name = "push_timeout")
    private Long pushTimeout;

    @Column(name = "push_timeout_datetime")
    private Date pushTimeoutDatetime;

    @Column(name = "region")
    private String region;

    @Column(name = "request_datetime")
    private Date requestDatetime;

    @Column(name = "speed_to_answer")
    private Long speedToAnswer;

    @Column(name = "status")
    private String status;

    @Column(name = "user_name")
    private String userName;

    @Column(name = "user_role")
    private String userRole;

    @Column(name = "insert_datetime")
    private Date insertDatetime;

    @Column(name = "modified_datetime")
    private Date modifiedDatetime;

}
