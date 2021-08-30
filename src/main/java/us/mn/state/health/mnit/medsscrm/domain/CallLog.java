package us.mn.state.health.mnit.medsscrm.domain;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "covid_case_calllog")
@Data
public class CallLog {

    @Id
    @Column(name = "case_key")
    private Long caseKey;

    @Column(name = "case_id")
    private String caseId;

    @Column(name = "iteration")
    private Integer iteration;

    @Column(name = "call_attempt_date")
    private String callAttemptDate;

    @Column(name = "call_attempt_made_by")
    private String callAttemptMadeBy;

    @Column(name = "call_result")
    private String callResult;

    @Column(name = "call_log_comments")
    private String callLogComments;
}
