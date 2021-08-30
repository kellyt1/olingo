package us.mn.state.health.mnit.medsscrm.domain;

import lombok.Data;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Date;

@Entity
@Table(name = "covidintakepositiveuncoded")
@Data
public class CovidIntakePositiveUncoded {

    @Id
    @Column(name = "case_key")
    private Long caseKey;

    @Column(name = "case_id")
    private String caseId;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "middle_name")
    private String middleName;

    @Column(name = "birth_date")
    private Date birthDate;

    @Column(name = "email")
    private String email;

    @Column(name = "street_1")
    private String streetAddress;

    @Column(name = "city")
    private String city;

    @Column(name = "state")
    private String state;

    @Column(name = "zip")
    private String zip;

    @Column(name = "county")
    private String county;

    @Column(name = "telephone_home")
    private String telephoneHome;

    @Column(name = "telephone_cell")
    private String telephoneCell;

    @Column(name = "telephone_work")
    private String telephoneWork;

    @Column(name = "covid_mn_id")
    private String mnId;

    @Column(name = "intake_complete_date_time")
    private String intakeCompleteDateTime;

    @Column(name = "specimen_date")
    private String specimenDate;

    @Column(name = "preferred_language")
    private String preferredLanguage;

    @Column(name = "language_interview")
    private String languageInterview;

    @Column(name = "interview_jurisdiction")
    private String interviewJurisdiction;

    @Column(name = "subregion_based_jurisdiction")
    private String subregionBasedJurisdiction;

    @Column(name = "tribe_name")
    private String tribeName;

    @Column(name = "living_reservation")
    private String livingReservation;

    @Column(name = "reservation_name")
    private String reservationName;

    @Column(name = "case_interview_status")
    private String caseInterviewStatus;

    @Column(name = "modification_date")
    private Date modificationDate;

    @Column(name = "subject_id")
    private String subjectId;

    @Column(name = "calc_interview_jurisdiction")
    private String calcInterviewJurisdiction;

    @Column(name = "modification_date_fmt")
    private String modificationDateFmt;


}
