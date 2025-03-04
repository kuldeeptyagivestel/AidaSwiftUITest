//
//  Localization+Key.swift
//  UmbrellaApp
//
//  Created by Emre Karasahin on 10.07.2018.
//  Copyright © 2018 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

public enum LocalizationKey: String {
    case company_name
    case app_name
    case welcome
    case email
    case password
    case forget_password
    case login
    case or
    case login_with_vestel
    case login_with_google
    case login_with_apple
    case register
    case male
    case female
    case other
    case register_name
    case register_surname
    case register_email
    case register_password
    case register_password_requirements
    case register_password_continue
    case register_step_1
    case register_step_2
    case register_step_3
    case register_step_4
    case register_approve_privacy
    case register_approve_usage
    case no_target_set
    case login_already_have
    case add_new_family_member
    case update_family_member
    case register_email_activation_title
    case register_email_activation_desc
    case register_email_activation_not_received
    
    //MARK: - CONSENT MANAGEMENT
    case consent_mgmt_title
    case consent_mgmt_message_title
    case consent_mgmt_whatsapp_title
    case consent_mgmt_approve_message_consent
    case consent_mgmt_approve_whatsapp_consent
    case consent_mgmt_sms
    case consent_mgmt_phone
    case consent_mgmt_email
    
    //MARK: CRM COGNITO ERROR:
    case error_to_get_jwt_token
    case error_unable_to_login
    case cannot_migrate_user
    case incorrect_user_credentials
    
    //MARK: - PASSWORD ERROR
    case incorrect_password
    case password_reset_error
    
    //MARK: - ACCOUNT VALIDATION ERROR
    case account_setup_error
    case account_disabled
    case account_not_Active
    case not_accepted_agreement
    case agreement_error
    case account_blocked
    case account_confirmation_error
    case you_are_all_set
    case register_account_create_success_continue
    
    //MARK: - UPDATE PROFILE
    case unable_update_profile
    case account_verification_failed
    case unable_update_profile_photo
    
    //MARK: - DELETE ACCOUNT
    case delete_account
    case delete_account_popup_title
    case delete_account_popup_desc
    case delete_account_success_popup_title
    case delete_account_success_popup_desc
    case delete_account_fail_popup_title
    case delete_account_fail_popup_desc

    //MARK: - NETWORK API ERRORS
    case unknown_error
    case unexpected_state_error
    case no_internet
    case request_failed
    case invalid_response
    case decoding_error
    case authentication_error
    case server_unavailable
    case file_upload_failed
    case file_download_failed
    case session_expired
    case timeout
    
    //MARK: - FIREBASE DATASTORE API ERRORS
    case fb_user_not_found
    case fb_no_record_found
    case fb_authentication_error
    case fb_permission_denied
    case fb_resource_not_found
    case fb_resource_already_exists
    case fb_cancelled
    case fb_deadline_exceeded
    case fb_service_unavailable
    case fb_data_loss
    
    //MARK: - FIREBASE STORAGE ERRORS
    case firebaseDownloadError
    case firebaseSaveError
    case firebaseFileNotFound
    case firebasePermissionError
    
    //MARK: - DATABASE CRUD OPs ERRORS
    case db_create_record_error
    case db_read_record_error
    case db_update_record_error
    case db_delete_record_error
    case db_cleanup_error

    //MARK: - BUTTON TITle
    case done
    
    case register_account_create_success_title
    case register_account_create_success_desc
    
    case login_cognito_verify_contact_info_title
    case login_cognito_verify_contact_info_desc
    case login_cognito_verify_button
    case login_cognito_system_change_title
    case login_cognito_system_change_desc
    case login_cognito_system_change_bold_part
    case login_cognito_system_change_password
    case login_cognito_system_change_password_button
    
    case register_link
    
    case profile_detail_text
    case profile_gender_update
    case profile_weight_update
    case profile_height_update
    case profile_birthday_update
    case profile_detail
    
    case onboard_step_1_title
    case onboard_step_1_desc
    case onboard_step_2_title
    case onboard_step_2_desc
    case onboard_step_3_title
    case onboard_step_3_desc
    case onboard_step_3_button
    
    case set_goals_title
    case set_goals_desc
    case set_goals_weight
    
    case profile_name
    case profile_surname
    case profile_gender
    case profile_birthdate
    case profile_height
    case profile_weight
    case profile_target_weight
    case profile_edit_desc
    case profile_desc
    
    case height
    case weight
    case set_target_weight
    
    case devices_add_device
    case devices_title
    case search_device
    case device_banner_url
    case device_paired
    
    case device_activate_bluetooth
    case device_turnon_bluetooth
    
    case device_connect_connecting_title
    case device_not_connect_connecting_title
    
    case device_connect_approve_title
    case device_connect_approve_desc
    
    case device_connect_complete_title
    case device_connect_fail_title
    case device_connect_fail_desc
    
    case smartwatchv2_connecting_title
    case smartwatchv2_connecting_desc
    
    ///Remove Device Screen Texts
    case smartwatch_removed_device_succeed
    case smartwatch_removed_device_subtitle
    case smartwatch_removed_device_option1
    case smartwatch_remove_option2_part_one
    case smartwatch_remove_option2_part_part_two
    
    case smartwatchv2_binding_title_p1
    case smartwatchv2_binding_title_p2
    
    case device_disconnected
    
    case device_sync
    case device_sync_progress
    
    case smartwatch_remove_fail_title
    case smartwatch_remove_fail_detail
    case smartlight_connected
    case smartlight_sleep_reminder
    case smartlight_gesture_control
    case smartlight_program
    case smartlight_night_light
    case smartlight_device_id
    case smartlight_firmware_update
    case smartlight_user_manual
    case smartlight_faq
    case smartlight_reset
    case smartlight_reset_alert_title
    case smartlight_reset_alert_detail
    case smartlight_control_device
    case disconnect
    case smartlight_program_add
    case smartlight_program_backbtn_title_add
    case smartlight_noprogram_title
    case smartlight_noprogram_desc
    case smartlight_program_light
    case smartlight_autoturnoff
    case smartlight_autoturnoff_duration
    case smartlight_autoturnoff_desc
    case smartlight_program_volume
    case smartlight_program_name
    case smartlight_program_maxcount
    
    case smartband_calling_notifications
    case smartband_message_notifications
    case smartband_find_my_phone
    case smartband_anti_lost
    case smartband_control_music
    case smartband_wrist_up_time_display
    case smartband_hr_display
    case smartband_hr_display_title
    case smartband_find_my_band
    case smartband_alarm
    case smartband_app_notifications
    case smartband_app_notifications_title
    case smartband_take_photo
    case smartband_sedentary_title
    case smartband_sedentary
    case smartband_reset_alert_title
    case smartband_reset_alert_detail
    case smartband_repeat_alarm
    case pair_problem
    
    case smartwatch_scan_imgage_link
    case smartwatchv2_scan_imgage_link
    case smartwatch_calling_notifications
    case smartwatch_message_notifications
    case smartwatch_find_my_phone
    case smartwatch_anti_lost
    case smartwatch_control_music
    case smartwatch_wrist_up_time_display
    case smartwatch_hr_display
    case smartwatch_hr_display_title
    case smartwatch_alarm
    case smartwatch_app_notifications
    case smartwatch_app_notifications_title
    case smartwatch_sedentary
    case smartwatch_sedentary_title
    case smartwatch_firmware_update
    case smartwatch_same_alarm_title
    case smartwatch_same_alarm_desc
    case smartwatch_sos
    
    case smartwatch_reset_failure_title
    
    case sedentary_title
    case sedentary_reminder_choice
    case sedentary_time
    case sedentary_start_end_time
    case sedentary_desc
    
    case hrmonitor_measure
    case hrmonitor_reminder
    case hrmonitor_reminderinfo
    case hrmonitor_desc
    case hrmonitor_unit
    
    case photo_title
    case photo_desc
    
    case contacts_permission_title
    case contacts_permission_desc
    case location_permission_title
    case location_permission_desc
    case camera_permission_title
    case camera_permission_desc
    case camera_permission_desc_qr_scan
    case photos_permission_title
    case photos_permission_desc
    case camera_loading
    case settings_loading
    case settings_title
    case settings_notifications
    case settings_password
    case settings_backup
    case settings_about
    case settings_language_title
    case settings_faq
    case settings_logout
    case smartband_name_beauty
    case smartwatch_name_beauty
    case smartwatchv2_name_beauty
    case smartwatchv2max_name_beauty
    case smartwatchv3_name_beauty
    case smartscale_name_beauty
    case smartlight_name_beauty
    case airpurifier_name_beauty
    case sleeptracker_name_beauty
    case smartlightv2_name_beauty
    case just_phone
    case source
    case go_to_settings
    
    case settings_notifications_desc
    case settings_notifications_daily_step
    case settings_notifications_water_intake
    case settings_notifications_distance
    case settings_notifications_calorie
    case settings_notifications_target_weight
    
    case settings_change_password
    case settings_password_desc
    
    case hour_short
    case minute_short
    case unit_step
    case unit_sleep
    case unit_water
    case unit_weight
    case weight_details
    case guest
    case add_family_member
    case family_members
    case family_member_desc
    case reached_goal
    case update_goal
    case keep_goal
    
    //Step
    case step_title
    case step_desc
    case step
    
    //Sleep
    case sleep_title
    case sleep_desc
    case sleep_deep_sleep
    case sleep_light_sleep
    case sleep_rem_sleep
    case sleep_awake
    case sleep_time_daily
    case wake_time_daily
    case sleep_full_time_daily
    case sleep_deep_sleep_graph
    case sleep_light_sleep_graph
    case sleep_rem_sleep_graph
    case sleep_awake_graph
    case sleep_avg_light
    case sleep_avg_deep
    case sleep_avg_sleeptime
    case sleep_add
    case sleep_total
    case sleep_add_time
    case sleep_start_time
    case sleep_end_time
    case sleep_added
    case sleep_add_alert
    case sleep_future_alert
    
    case tab1
    case tab2
    case tab3
    case tab4
    
    //Water
    case water_title
    case water_desc
    case water_total_intake
    case water_intake_added
    case water_average_intake
    
    //Calorie
    case calorie_title
    case calorie_desc
    
    // /Hearthrate
    case hr_title
    case hr_desc
    
    //Distance
    case distance_title
    case distance_desc
    
    //Weight
    case weight_added
    case weight_title
    case add_weight
    case weight_desc
    case weight_latest
    case weight_my_data
    case barefoot_text
    case barefoot_detail_text
    
    case bmi_desc
    case bmi_title
    case bmi
    case bmi_value_underweight
    case bmi_value_normal
    case bmi_value_owerweight
    case bmi_value_obese
    
    case body_fat_title
    case body_fat_desc
    case body_fat_inadequate
    case body_fat_low
    case body_fat_normal
    case body_fat_fat
    case body_fat_too_fat
    
    case muscle_title
    case muscle_desc
    case muscle_inadequate
    case muscle_normal
    case muscle_perfect
    
    case body_water_title
    case body_water_desc
    case body_water_inadequate
    case body_water_normal
    case body_water_perfect
    
    case bodysalts_title
    case bodysalts_desc
    case bodysalts_inadequate
    case bodysalts_normal
    case bodysalts_perfect
    
    case visceral_fat_title
    case visceral_fat_desc
    case visceral_fat_normal
    case visceral_fat_fat
    case visceral_fat_danger
    
    case bmr_title
    case bmr_desc
    case bmr_slow
    case bmr_fast
    
    case heartRate_low
    case heartRate_normal
    case heartRate_high
    case hr_measure
    case hr_minvalue
    case hr_maxvalue
    case hr_avgvalue
    
    case update_profile_popup_title
    case update_profile_popup_desc
    case update_profile_ok_button
    case update_profile_not_now
    
    case feature_data_not_found_title
    case feature_data_not_found_desc
    case feature_data_not_found_desc_step
    case feature_data_not_found_desc_calorie
    case feature_data_not_found_desc_distance
    case feature_data_not_found_desc_weight
    case feature_data_not_found_desc_heartrate
    case feature_data_not_found_desc_water
    case feature_data_not_found_desc_sleep
    case feature_data_not_found_desc_stress
    case feature_data_not_found_desc_o2level
    
    case feature_maximum_in_today
    case feature_minimum_in_today
    case feature_time_between
    case feature_last_update
    case feature_minimum
    case feature_maximum
    case feature_average
    case feature_average_graph
    case hoursGraphLabel
    case feature_daily
    case feature_weekly
    case feature_monthly
    case update
    case water_glass_water_text
    case beverage_glass_water_text
    case bottle_water_text
    case carafe_water_text
    case error
    case warning
    case info
    case alert
    case importantUpdate
    case alert_no_user_found
    case incorrect_email_and_pass
    case confirm_email_title
    case confirm_email
    case general_login_fail
    case too_many_bad_password_Try
    case activation
    case account_created
    case successful
    case activation_email
    case re_entry
    case confirm_terms_and_policy
    case goal
    case set
    case set_step
    case set_step_text
    case set_water
    case set_water_text
    case set_distance
    case set_distance_text
    case set_calorie
    case set_calorie_text
    case no_update_today
    case save
    case clear
    case reset
    case app_version_title
    case privacy_policy_title
    case terms_and_conditions_title
    case privacy_policy_nointernet_title
    case privacy_policy_nointernet_desc
    case terms_and_conditions_nointernet_title
    case terms_and_conditions_nointernet_desc
    case add_water
    case valid_email
    case register_privacy
    case register_terms
    case emailAlert
    case checkEmail
    case sendLinkEmail
    case noUserFound
    case no_backup_found
    case smartband_reset
    case add_device_title
    case no_device_connected
    case smartlight_tab_white
    case smartlight_tab_color
    case smartlight_tab_color_cycle
    case smartlight_tab_favorite
    case smartlight_add_fav
    case smartlight_add_popup_desc
    case smartlight_name
    case smartlight_name_desc
    case smartlight_config
    case smartlight_config_name_title
    case smartlight_config_desc
    case smartlight_device_name
    case smartlight_device_name_error
    case smartlight_fav_title
    case smartlight_fav_desc
    case device_network
    case device_network_name
    case device_network_password
    
    case unattended_weights
    case enter_valid_password
    case error_email_not_valid
    case error_name_not_valid
    case error_surname_not_valid
    case error_password_contains_number
    case error_password_contains_uppercase
    case error_password_contains_special_char
    case error_password_contains_length
    case logout_are_you_sure
    case error_password_dont_match
    
    case not_connected_step_title
    case not_connected_step_desc
    
    case not_connected_calorie_title
    case not_connected_calorie_desc
    
    case not_connected_sleep_title
    case not_connected_sleep_desc
    case not_connected_sleep_additional_desc

    case not_connected_distance_title
    case not_connected_distance_desc
    
    case not_connected_hr_title
    case not_connected_hr_desc
    
    case not_connected_water_title
    case not_connected_water_desc
    
    case not_connected_weight_title
    case not_connected_weight_desc
    case not_connected_weight_additional_desc
    
    case not_connected_stress_title
    case not_connected_stress_desc
    
    case not_connected_bloodox_title
    case not_connected_bloodox_desc
    
    case not_connected_menstrual_cycle_title
    case not_connected_menstrual_cycle_desc
    case add_menstrual_cycle
    
    case connect_smartband
    case not_connected_skip
    
    case sedentary_start_end_title
    case sedentary_start_end_desc
    case sedentary_start_time
    case sedentary_end_time
    case battery_info
    case connected
    case not_connected
    case device_connect
    case app_notifications_desc
    case alarm_list
    case add_alarm
    case set_alarm_label
    case set_alarm
    case add_alarm_backbtn_title
    case nomore_than_five
    case cannot_off_music_and_light_features
    
    case sl_alarm_title
    case sl_alarm_repeat
    case sl_alarm_snooze
    case sl_alarm_music
    case sl_alarm_wakeup_light
    case sl_alarm_wakeup_music
    case sl_alarm_howto_close
    
    case alarm_time
    case repeat_title
    case time_interval_not_set
    case unit_sedentary
    case update_alarm
    case alarm_retry_day_none
    case add_device_smartband_name
    case add_device_smartband_desc
    case add_device_smartwatch_name
    case add_device_smartwatch_desc
    case add_device_smartwatchv2_name
    case add_device_smartwatchv2max_name
    case add_device_smartwatchv3_name
    case add_device_smartwatchv2_desc
    case add_device_smartwatchv2max_desc
    case add_device_smartwatchv3_desc
    case add_device_scale_name
    case add_device_scale_desc
    case add_device_light_name
    case add_device_light_desc
    case add_device_light_plugged
    case scan_device_desc
    case repeat_days_not_found
    case scan_device_no_found
    case try_following_pair_again
    case turn_on_bluetooth_pair_again
    case scan_again
    
    //MARK: -
    //MARK: - REPORT A PROBLEM MODULE
    case report_a_problem
    case send
    case tell_us_your_problem
    case device_model
    case none
    case choose_device_Error_title
    case empty_text
    case report_sent_popup_title
    case report_sent_popup_desc
    
    case continueText
    case finish
    case ok
    case select_from_gallery
    case data_sync_progress
    case bluetooth_access_denied_title
    case bluetooth_access_denied_Desc
    case backup_progress
    case backup_completed
    case error_password_not_found
    case error_name_not_found
    case error_surname_not_found
    case error_email_not_found
    case placeholder_current_password
    case placeholder_new_password
    case placeholder_new_password_re
    case change_password_title
    case change_password_success
    case change_password_old_password_incorrect
    case change_password_error
    case user_activation_already_activated
    case user_activation_generic_error
    case resetPassword
    
    case smartwatchv2_call_notification
    case smartwatchv2_message_notification
    case smartwatchv2_health_monitor
    case smartwatchv2_dont_disturb
    case smartwatchv2_exercise_recognition
    case smartwatchv2_emergency
    case smartwatchv2_find_my_phone
    case smartwatchv2_music_control
    case smartwatchv2_wristup
    case smartwatchv2_weather_notification
    case smartwatchv2_auto_brightness
    case smartwatchv2_shortcuts
    case smartwatchv2_activity_display
    case smartwatchv2_units
    case smartwatchv2_device_language
    case smartwatchv2_date_time
    case smartwatchv2_faq
    case smartwatchv2_device_info
    case smartwatchv2_reset
    case smartwatch_v2_restart
    
    //Smart Watch V2 Max: Features are similar except some
    case smartwatchv2max_activity_recognition
    case smartwatchv2max_weather_display
    case smartwatchv2max_reset
    case smartwatchv2max_restart
    
    case restarted_successfully
    
    //ERROR Alert
    //MARK: - Error
    case brightness_sync_failure_details
    case brightness_sync_failure
    
    //Scale
    case scale_vfit
    case scale_pregnancy_mode
    case scale_pregnancy_desc
    case scale_all_data
    case scale_delete_data
    case scale_family_members
    case scale_viewdetail
    case scale_guestdetail
    case scale_guestinfo
    case scale_guestdetail_desc
    case scale_guestdetail_button
    
    //Smart scale onboarding
    case scale_step_1_title
    case scale_step_1_desc
    case scale_step_2_title
    case scale_step_2_desc
    case scale_step_3_title
    case scale_step_3_desc
    case scale_step_4_title
    case scale_step_4_desc
    case scale_step_4_button
    
    //Reach Goal Popup
    case target_weight
    case target_steps
    case target_distance
    case target_calorie
    case target_water
    case congratulations
    
    //Notifications
    case notification
    case no_notifications
    case no_notifications_desc
    case open_notifications
    case open_notifications_desc
    case turn_on_notifications
    case edit_data
    case edit
    
    //UnattendendWeightFoundController
    case unattendend_weight_title
    case unattendend_weight_desc
    case unattendend_weight_cancel
    case unattendend_weight_show
    
    case lastUpdate
    case share
    
    //SmartWatch
    case smartwatch_time_date
    case smartwatch_not_disturb
    case smartwatch_activity_display
    case time_format
    case not_disturb
    
    case time_format_12
    case time_format_24
    case app_notifications_desc_for_smartwatch
    case swhrmonitor_desc
    case smartwatch_sedentary_desc
    
    //Activity Display
    case add_activity
    case walk
    case run
    case hike
    case climbing
    case bike
    case treadmill
    case spinning
    case yoga
    case dance
    case workout
    case badminton
    case football
    case basketball
    case tennis
    case no_selected_activity
    case set_time
    case set_time_desc
    case sleep_reminder_desc
    case night_light_desc
    case nightlight_title_start_end_title
    case nightlight_title_configuration
    case gesture_control_wave
    case gesture_control_wave_information
    case gesture_control_hover
    case gesture_control_disable
    case gesture_control_switch_music
    case gesture_control_switch_light_color
    case gesture_control_switch_light_color_title
    case gesture_control_switch_light_color_information
    case gesture_control_switch_light_color_favorites
    case gesture_control_switch_light_color_toast
    case gesture_control_switch_play_pause_music
    case firmware_update_desc
    case firmware_upgrade
    case firmware_wait
    case firmware_updated
    case firmware_updated_desc
    case firmware_failed
    case firmware_failed_desc
    case firmware_already_updated
    case firmware_found
    case firmware_found_desc
    case firmware_found_desc_light
    case firmware_found_light
    
    //Menstrual Tracking
    case menstrual_length
    case menstrual_length_desc
    case menstrual_cycle_length
    case menstrual_cycle_length_desc
    case last_menstrual_date
    case last_menstrual_date_desc
    case menstrual_reminder
    case menstrual_reminder_desc
    case ovulation_reminder
    case ovulation_reminder_desc
    case notification_time
    case notification_time_desc
    case smartwatch_menstrual_tracking_desc
    case smartwatch_menstrual_tracking_title
    case smartwatch_menstrual_tracking_info
    case smartwatch_menstrual_tracking_notification
    case smartwatch_menstrual_tracking_info_desc
    case smartwatch_menstrual_tracking_notification_desc
    case days
    case days_in_advance
    case device_not_found_go_settings
    case scale_not_found
    case brightness
    
    //Days
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun
    case once
    
    //Alert
    case internet_connection
    case error_occured
    
    //Wallpaper Add Photo missing
    case error_photo_missing_title
    case error_photo_missing_desc
    
    //All alarm set error
    case error_alarm_max
    
    //Smart light onboarding
    case light_step_1_title
    case light_step_1_desc
    case light_step_2_title
    case light_step_2_desc
    case light_step_3_title
    case light_step_3_desc
    case light_step_4_title
    case light_step_4_desc
    
    //Smart light user manual
    case light_user_manual_1
    case light_user_manual_2
    case light_user_manual_3
    case light_user_manual_4
    case light_user_manual_5
    case light_user_manual_6
    
    case sleep_type_wakeup
    case sleep_type_appoinment
    case sleep_type_exercise
    case sleep_type_medicine
    case sleep_type_meetup
    case sleep_type_party
    case sleep_type_sleep
    case sleep_type_title
    
    case alarm_type_getup
    case alarm_type_appointment
    case alarm_type_workout
    case alarm_type_medicine
    case alarm_type_meeting
    case alarm_type_party
    case alarm_type_go_to_bed
    
    case music
    case wakeup_light
    case set_alarm_music1
    case set_alarm_music2
    case set_alarm_music3
    case set_alarm_music4
    case set_alarm_music5
    case set_alarm_music6
    case set_alarm_music7
    case set_alarm_music8
    case set_alarm_music9
    
    case every_mon
    case every_tue
    case every_wed
    case every_thu
    case every_fri
    case every_sat
    case every_sun
    
    case snooze_alarm_title
    case snooze_alarm_duration
    case snooze_alarm_count
    case snooze_min
    case snooze_times
    case on
    case off
    
    case alarm_volume
    case alarm_preview
    case stop_alarm_preview
    
    case light
    case change_light_settings
    case now_playing
    case stopped
    case smartlight_faq_sl
    case question1
    case question2
    case question3
    case question4
    case question5
    case question6
    case question7
    case question8
    
    case answer1
    case answer2
    case answer3
    case answer4
    case answer5
    case answer6
    case answer7
    case answer8
    
    case light_settings
    case sea
    case wind
    case rain
    case solo
    case star
    case summer
    case sun_
    
    case control_smartlight_title
    case color_cycle_text
    case push_noti_title
    
    case smartlight_firmware_version
    case smartlight_firmware_old_version
    case smartlight_firmware_latest_version
    
    //Force update
    case forceUpdateTitle
    case forceUpdateDesc
    case forceupdateButton
    case updateDescFromRemote
    case updatedTermsAndConditionsTitle
    case updatedTermsAndConditionsDesc
    case updatedPrivacyPolicyTitle
    case updatedPrivacyPolicyDesc
    case updatedTCAndPPTitle
    case updatedTCAndPPDesc
    case updatedTCStep
    case updatedPPStep
    case updatedTCAndPPSecondStep
    case updatedAccept
    case updatedWarningTCAndPPTitle
    case updatedWarningTCTitle
    case updatedWarningPPTitle
    case updatedWarningTCAndPPDesc
    case updatedWarningTCDesc
    case updatedWarningPPDesc
    
    //Smartlight Sleep Mode
    case sleep_mode
    case sleep_mode_settings
    case sleep_mode_settings_title
    case sleep_mode_duration
    case sleep_mode_desc
    
    //AIRPURIFIER
    case add_device_airpurifier_name
    case add_device_airpurifier_desc
    case airpurifier_device_conf
    case connection_failed
    case try_again
    
    case please_wait
    case please_wait_syncing
    case device_name
    case wifi_access
    case enter_wifi_password_info
    case wifi_password
    case device_info
    case check_device_network
    
    case unbind_alert_detail
    case remove_device
    case device_remove_confirm_title
    case device_remove_confirm_desc
    case device_remove_confirm_btn_text
    case device_remove_confirm_title_v2watch
    case device_remove_confirm_desc_v2watch
    case confirm
    
    case sosContact
    case sosMessage
    case sosDesc
    case sosImageDesc
    case sosEmptyContactTitle
    case sosEmptyContactDesc
    case sosAddContact
    case search_on_contact
    case sosmax_contact
    case sos_contact_added
    case sos_addedlist_desc
    
    case cancel = "cancel"
    case privacy_and_terms
    case privacy_and_conditions
    case enable
    case disabled
    
    case already_registered
    case activation_error
    case activation_error_title
    case send_activation_link
    case not_activated_user
    case not_activated_user_desc
    
    case not_activated_account
    case not_activated_account_desc
    
    //MARK: -
    //MARK: - HOME DASHBOARD PAGES
    case no_data_available_to_display
    
    //MARK: -
    //MARK: - WATCH SETTINGS PAGES: V2 - V2MAX
    
    //MARK: Stress
    case stress_title
    case stress_range
    case stress_automeasure
    case stress_desc
    case stress_weekly_infotext
    case stress_monthly_infotext
    
    //MARK: Blood oxygen
    case blood_title
    case blood_what_is
    
    //MARK: Menstrual Cycle
    case menstrualCycle_title
    case menstrualCycleUpdate
    case menstrual_cycle_add_step1
    case menstrual_cycle_add_step2
    case menstrual_cycle_add_step3
    case menstrual_cycle_add_step4
    case menstrual_cycle_add_step5
    case menstrual_cycle_add_last_menstrual_date
    case menstrual_cycle_add_last_menstrual_date_desc
    case menstrual_cycle_add_menstrual_length
    case menstrual_cycle_add_menstrual_length_desc
    case menstrual_cycle_add_menstrual_cycle_length
    case menstrual_cycle_add_set_reminder
    case menstrual_cycle_add_set_reminder_desc
    case menstrual_cycle_add_set_notification_time
    case menstrual_cycle_add_set_notification_time_desc
    case last_menstrual
    case ovulation
    case cycle_length
    case menstrual_tracking
    case menstrual_cycle_info
    case menstrual_cycle_reminder
    case menstrual_days
    case ovulation_days
    case next_estimated_menstrual_days
    case menstrual_cycle_add_complete
    
    case later
    case today
    case `default`
    
    //MARK: Feature
    case market
    case all
    case my_library
    case new_arrivals
    case custom
    case photo
    case photodesc
    case already_installed
    case watchface
    case current
    case add_and_install
    case set_current
    case addphoto
    case changephoto
    case datetimecolor
    case watchv2_nointernet_title
    case watchv2_nointernet_desc
    case watchv2_camera
    case watchv2_gallery
    case watchv2_photoselect
    case watchv2_warning
    case watchv2_cameranotfound
    case watchv2_cropphoto
    
    case auto_brightness_title
    case auto_brightness_switch
    case auto_brightness_start_end_time
    case auto_brightness_desc
    case downloading
    case watchv2_call_notification_title
    case watchv2_call_notification
    case watchv2_call_notification_delay
    case watchv2_call_notification_desc
    case watchv2Max_call_notification_desc
    case watchv2_exercise_recognition_title
    case watchv2_exercise_recognition_run
    case watchv2_exercise_recognition_walk
    case watchv2_exercise_recognition_desc
    
    //MARK: WatchV2 FAQ
    case watchv2_q1
    case watchv2_q2
    case watchv2_q3
    case watchv2_q4
    case watchv2_q5
    case watchv2_q6
    case watchv2_q7
    case watchv2_q8
    case watchv2_q9
    case watchv2_q10
    case watchv2_q11
    case watchv2_q12
    case watchv2_q13
    case watchv2_q14
    case watchv2_q15
    case watchv2_q16
    case watchv2_q17
    case watchv2_q18
    case watchv2_q19
    case watchv2_q20
    case watchv2_q21
    case watchv2_q22
    case watchv2_q23
    case watchv2_q24
    case watchv2_q25
    case watchv2_q26
    
    case watchv2_a1
    case watchv2_a2
    case watchv2_a3
    case watchv2_a4
    case watchv2_a5
    case watchv2_a6
    case watchv2_a7
    case watchv2_a8
    case watchv2_a9
    case watchv2_a10
    case watchv2_a11
    case watchv2_a12
    case watchv2_a13
    case watchv2_a14
    case watchv2_a15
    case watchv2_a16
    case watchv2_a17
    case watchv2_a18
    case watchv2_a19
    case watchv2_a20
    case watchv2_a21
    case watchv2_a22
    case watchv2_a23
    case watchv2_a24
    case watchv2_a25
    case watchv2_a26
    
    //MARK: Watch v2 - health monitor
    case watchv2_healthmonitor
    case watchv2_hm_enabled
    case watchv2_hm_disabled
    case watchv2_hm_hearth
    case watchv2_hm_stress
    case watchv2_hm_water
    case watchv2_hm_sedentary
    case watchv2_hm_menstrual
    case watchv2_hm_desc
    
    case watchv2_hm_hr_title
    case watchv2_hm_hr_desc
    case watchv2_hm_hr_auto
    case watchv2_hm_hr_manual
    
    case watchv2_hm_stress_title
    case watchv2_hm_stress_desc
    case watchv2_hm_stress_zone
    case watchv2_hm_stress_relax
    case watchv2_hm_stress_normal
    case watchv2_hm_stress_medium
    case watchv2_hm_stress_high
    
    case watchv2_hm_dr_title
    case watchv2_hm_dr_reminder
    case watchv2_hm_dr_startend
    case watchv2_hm_dr_repeat
    case watchv2_hm_dr_duration
    case watchv2_hm_dr_desc
    case watchv2_hm_dr_settime
    case watchv2_hm_dr_starttime
    case watchv2_hm_dr_endtime
    case watchv2_hm_dr_reminderduration
    
    case watchv2_hm_war_title
    case watchv2_hm_war_reminder
    case watchv2_hm_war_startend
    case watchv2_hm_war_goal
    case watchv2_hm_war_repeat
    case watchv2_hm_war_desc
    case watchv2_hm_war_starttime
    case watchv2_hm_war_endtime
    
    case watchv2_hm_mc_title
    case watchv2_hm_mc_tracking
    case watchv2_hm_mc_menstrual_settings
    case watchv2_hm_mc_reminder_settings
    case watchv2_hm_mc_desc
    case watchv2_hm_mc_menstrual_length
    case watchv2_hm_mc_menstrual_cycle_length
    case watchv2_hm_mc_last_menstrual_date
    case watchv2_hm_mc_menstrual_reminder
    case watchv2_hm_mc_ovulation_reminder
    case watchv2_hm_mc_notification_time
    case watchv2_hm_mc_menstrual_reminder_desc
    
    case watchv2_firmware
    case watchv2_firmware_title
    case watchv2_firmware_info
    
    case watchv2_deviceinfo_title
    case watchv2_deviceinfo_modelno
    case watchv2_deviceinfo_version
    case watchv2_deviceinfo_blename
    case watchv2_deviceinfo_mac
    case watchv2_deviceinfo_updatetime
    
    case watchv2_alarm
    case watchv2_alarm_name
    case watchv2_alarm_type
    case watchv2_alarm_snooze
    case scan_QR
    case watchv2_restart_title
    case watchv2_reboot_title
    case watchv2_reboot_restart
    
    //MARK: shortcuts
    case show_functions
    case hide_functions
    case health_data
    case heartrate
    case stress_level
    case last_activity
    case weather
    case music_control
    case shortcut_info
    case music_control_info
    case shortcut_v2max_info
    
    //MARK: activity display
    case outdoor_running
    case indoor_running
    case outdoor_walking
    case indoor_walking
    case hiking
    case indoor_bicycle
    case outdoor_biking
    case cricket
    case pool_swim
    case swim
    case v2_yoga
    case rowing
    case eliptic
    case fitness
    
    //MARK: message notifications
    case watchv2_msg_notification_title
    case allow_notifications
    case allow_notifications_desc
    case APP_TYPE_SMS
    case APP_TYPE_CALENDAR
    case APP_TYPE_WHATSAPP
    case APP_TYPE_INSTAGRAM
    case APP_TYPE_FACEBOOK
    case APP_TYPE_SKYPE
    case APP_TYPE_TWITTER
    case APP_TYPE_GMAIL
    case APP_TYPE_MESSENGER
    case APP_TYPE_SNAPCHAT
    case APP_TYPE_WECHAT
    case APP_TYPE_LINKEDIN
    case APP_TYPE_TELEGRAM
    case APP_TYPE_SLACK
    
    //MARK: do not disturb
    case duringDay
    case startEndTime
    case duringNight
    case doNotDisturbDesc
    case setStartEndTime
    case setStartEndTimeNight
    case startTime
    case endTime
    
    //MARK: language
    case smartwatchv2_device_language_title
    case systemLanguage
    case turkish
    case english
    case german
    case spanish
    case french
    case italian
    case russian
    case portuguese
    
    //MARK: datetime
    case timeformat
    case time12
    case time24
    case weekstart
    case saturday
    case sunday
    case monday
    
    //MARK: units
    case lengthUnit
    case tempratureUnit
    case mkm
    case feetmile
    case celcius
    case fahrenheit
    
    //MARK: bloodoxygen
    case whatsbloddox
    case bloodoxtitle
    case blooxoxdesc
    case risk
    case low
    case normal
    case precautions
    case precautionsdesc
    
    case watchv2_blenotconnected
    
    //MARK: sleep
    case dataSource
    case sleepRatio
    case deepSleep
    case lightSleep
    case rem
    case awake
    case respiratoryQuality
    case sleep_wake_up_times
    case leave_the_bed
    case sleepScore
    case sleepScoreLower
    case sleepPattern
    case score
    case scoreDesc
    case sleep_quality
    case dataSoruceCommonSelect
    case sleepMusicTime
    case sleep_pattern_status
    case sleep_pattern_regular
    case sleep_pattern_irregular
    case sleep_pattern_wakeup_time
    case sleep_pattern_sleep_time
    
    //MARK: Watch V2/V2 Max - Connection Errors
    case unsuccessfulAddDevice
    case unsuccessfulAddDeviceDesc
    case connection_failed_due_to_pairing_error_desc
    case connection_failed_title
    case connection_failed_subtitle
    case connection_failed_desc
    case connection_failed_device_corrupted
    
    //MARK: - WATCH DeviceConfig Page: V3
    case factoryReset
    case restartTheDevice
    case firmwareUpdate
    case deviceInfo
    case charging
    case watchv3_deviceinfo_macAddress
    case watchv3_deviceinfo_firmwareVersion
    case watchv3_deviceinfo_resourcePackVersion
    case watchv3_deviceinfo_deviceLanguageVersion
    case watchv3_deviceinfo_currentVersion
    case allFaces
    case dynamic
    case simple
    case custom_watchFace_desc
    case selectFromAlbum
    case watchFaceRecords
    case favorites
    case installedWatchFaces
    case builtinWatchFaces
    case takeAPhoto
    case selectTextColor
    case selectTextLocation
    //MARK: - V3 Features
    
    //MARK: Calls
    case calls
    case incomingCallAlert
    case frequentContacts
    //MARK: Notifications
    case notifications
    
    //MARK: Alarm
    case alarm
    
    //MARK: Health Monitor
    case healthMonitor
    
    //MARK: Do Not Disturb Mode
    case doNotDisturbMode
    
    //MARK: Sport Recognition
    case sportRecognition
    
    //MARK: Find My Phone
    case findMyPhone
    
    //MARK: Music Control
    case musicControl
    
    //MARK: Weather Display
    case weatherDisplay
    
    //MARK: Shortcuts
    case shortcuts
    
    //MARK: Sport Display
    case sportDisplay
    
    //MARK: Device Language
    case deviceLanguage
    
    //MARK: -
    //MARK: -  AIRPURIFIER
    case airpurifier_app_transition_title
    case airpurifier_app_transition_desc
    case go_to_app_store
    
    //MARK: -
    //MARK: -  SLEEP TRACKER
    case smartSleepTracker
    case sleeptrackerStartConnectionDesc
    case sleeptrackerConnectionStep1
    case sleeptrackerConnectionDesc
    case sleeptrackerConnectionStep2
    case sleeptrackerConnectionStep2Desc
    case wireless_network_selection
    case wireless_network_selection_desc
    case remember_wifi_pass
    case connecting_wifi
    case installation_complete
    case change_wifi
    case configFail
    case configFailDescTitle
    case configFailDesc
    case wifiChangeFailTitle
    case wifiChangeFailDesc
    case importantInstructions
    
    case sleepTracker_installation_succeed_desc
    case sleepace_tips1_title
    case sleepace_tip_desc
    
    case sleepace_tips1
    
    case sleeptracker_q1
    case sleeptracker_q2
    case sleeptracker_q3
    case sleeptracker_q4
    case sleeptracker_q5
    case sleeptracker_q6
    case sleeptracker_a1
    case sleeptracker_a2
    case sleeptracker_a3
    case sleeptracker_a4
    case sleeptracker_a5
    case sleeptracker_a6
    case sleeptracker_important_instructions
    case sleeptracker_firmware_update
    case sleeptracker_firmware_update_title
    case sleeptracker_firmware_update_text
    
    //Select_device_detail_data_message
    case select_device_detail_distance_message
    case select_device_detail_step_message
    
    case justMinute
    case justHour
    
    // SleepTrackerSleepScoreViewController
    case SleepTrackerSleepScoreViewController_title
    case SleepTrackerSleepScoreViewController_desc
    case SleepTrackerSleepScoreViewController_affect
    case SleepTrackerSleepScoreViewController_list1
    case SleepTrackerSleepScoreViewController_list2
    case SleepTrackerSleepScoreViewController_list3
    case SleepTrackerSleepScoreViewController_list4
    case SleepTrackerSleepScoreViewController_list5
    case SleepTrackerSleepScoreViewController_list6
    case SleepTrackerSleepScoreViewController_list7
    case SleepTrackerSleepScoreViewController_list8
    case SleepTrackerSleepScoreViewController_list9
    case SleepTrackerSleepScoreViewController_list10
    case SleepTrackerSleepScoreViewController_list11
    case SleepTrackerSleepScoreViewController_list12
    case SleepTrackerSleepScoreViewController_list13
    case SleepTrackerSleepScoreViewController_list14
    case SleepTrackerSleepScoreViewController_list15
    case SleepTrackerSleepScoreViewController_list16
    case SleepTrackerSleepScoreViewController_list17
    case SleepTrackerSleepScoreViewController_list18
    case SleepTrackerSleepScoreViewController_list19
    case SleepTrackerSleepScoreViewController_list20
    case SleepTrackerSleepScoreViewController_list21
    case SleepTrackerSleepScoreViewController_celltitle
    case SleepTrackerSleepScoreViewController_bad
    case SleepTrackerSleepScoreViewController_moderate
    case SleepTrackerSleepScoreViewController_good
    case SleepTrackerSleepScoreViewController_very_good
    case SleepTrackerSleepScoreViewController_no_data
    
    case sleep_tracker_status_desc_extension_day
    case sleep_tracker_status_desc_extension_week
    case sleep_tracker_status_desc_extension_month
    
    case sleep_tracker_status_bad_desc
    case sleep_tracker_status_moderate_desc
    case sleep_tracker_status_good_desc
    case sleep_tracker_status_verygood_desc
    
    case sleep_respirator_detail_page_explanation
    
    case SleepTrackerSleepScoreViewController_Sleep_1
    case SleepTrackerSleepScoreViewController_Sleep_Desc_1
    case SleepTrackerSleepScoreViewController_Sleep_Tips_1
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_1
    
    case SleepTrackerSleepScoreViewController_Sleep_2
    case SleepTrackerSleepScoreViewController_Sleep_Desc_2
    case SleepTrackerSleepScoreViewController_Sleep_Tips_2
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_2

    case SleepTrackerSleepScoreViewController_Sleep_3
    case SleepTrackerSleepScoreViewController_Sleep_Desc_3
    case SleepTrackerSleepScoreViewController_Sleep_Tips_3
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_3

    case SleepTrackerSleepScoreViewController_Sleep_4
    case SleepTrackerSleepScoreViewController_Sleep_Desc_4
    case SleepTrackerSleepScoreViewController_Sleep_Tips_4
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_4
    
    case SleepTrackerSleepScoreViewController_Sleep_5
    case SleepTrackerSleepScoreViewController_Sleep_Desc_5
    case SleepTrackerSleepScoreViewController_Sleep_Tips_5
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_5
    
    case SleepTrackerSleepScoreViewController_Sleep_6
    case SleepTrackerSleepScoreViewController_Sleep_Desc_6
    case SleepTrackerSleepScoreViewController_Sleep_Tips_6
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_6
    
    case SleepTrackerSleepScoreViewController_Sleep_7
    case SleepTrackerSleepScoreViewController_Sleep_Desc_7
    case SleepTrackerSleepScoreViewController_Sleep_Tips_7
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_7
    
    case SleepTrackerSleepScoreViewController_Sleep_8
    case SleepTrackerSleepScoreViewController_Sleep_Desc_8
    case SleepTrackerSleepScoreViewController_Sleep_Tips_8
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_8

    case SleepTrackerSleepScoreViewController_Sleep_9
    case SleepTrackerSleepScoreViewController_Sleep_Desc_9
    case SleepTrackerSleepScoreViewController_Sleep_Tips_9
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_9
    
    case SleepTrackerSleepScoreViewController_Sleep_10
    case SleepTrackerSleepScoreViewController_Sleep_Desc_10
    case SleepTrackerSleepScoreViewController_Sleep_Tips_10
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_10
    
    case SleepTrackerSleepScoreViewController_Sleep_11
    case SleepTrackerSleepScoreViewController_Sleep_Desc_11
    case SleepTrackerSleepScoreViewController_Sleep_Tips_11
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_11
    
    case SleepTrackerSleepScoreViewController_Sleep_12
    case SleepTrackerSleepScoreViewController_Sleep_Desc_12
    case SleepTrackerSleepScoreViewController_Sleep_Tips_12
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_12
    
    case SleepTrackerSleepScoreViewController_Sleep_13
    case SleepTrackerSleepScoreViewController_Sleep_Desc_13
    case SleepTrackerSleepScoreViewController_Sleep_Tips_13
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_13
    
    case SleepTrackerSleepScoreViewController_Sleep_14
    case SleepTrackerSleepScoreViewController_Sleep_Desc_14
    case SleepTrackerSleepScoreViewController_Sleep_Tips_14
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_14
    
    case SleepTrackerSleepScoreViewController_Sleep_15
    case SleepTrackerSleepScoreViewController_Sleep_Desc_15
    case SleepTrackerSleepScoreViewController_Sleep_Tips_15
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_15
    
    case SleepTrackerSleepScoreViewController_Sleep_16
    case SleepTrackerSleepScoreViewController_Sleep_Desc_16
    case SleepTrackerSleepScoreViewController_Sleep_Tips_16
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_16
    
    case SleepTrackerSleepScoreViewController_Sleep_17
    case SleepTrackerSleepScoreViewController_Sleep_Desc_17
    case SleepTrackerSleepScoreViewController_Sleep_Tips_17
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_17
    
    case SleepTrackerSleepScoreViewController_Sleep_18
    case SleepTrackerSleepScoreViewController_Sleep_Desc_18
    case SleepTrackerSleepScoreViewController_Sleep_Tips_18
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_18
    
    case SleepTrackerSleepScoreViewController_Sleep_19
    case SleepTrackerSleepScoreViewController_Sleep_Desc_19
    case SleepTrackerSleepScoreViewController_Sleep_Tips_19
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_19
    
    case SleepTrackerSleepScoreViewController_Sleep_20
    case SleepTrackerSleepScoreViewController_Sleep_Desc_20
    case SleepTrackerSleepScoreViewController_Sleep_Tips_20
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_20
    
    case SleepTrackerSleepScoreViewController_Sleep_21
    case SleepTrackerSleepScoreViewController_Sleep_Desc_21
    case SleepTrackerSleepScoreViewController_Sleep_Tips_21
    case SleepTrackerSleepScoreViewController_Sleep_Tips_Desc_21
    
    case sleep_movement_title
    case sleep_movement
    case sleep_mo_movement
    
    case sleep_heartbeat
    case sleep_respiratory_rate
    case sleep_medium
    case sleep_temperature
    case sleep_moisture
    case sleep_cellExp
    
    case sleeptracker_user_manual_first
    case sleeptracker_user_manual_second
    case humidity
    case temperature
    case delete
    case sleepace_sync
    case sleepace_device_banner_url
    case sleepace_device_banner_url_weekly
    
    // smartLightV2
    case smartLightV2
    case smartLightV2Description
    case smartLightV2Info
    case smartLightV2DeviceId
    case smartLightV2ConfigureTime
    case smartLightV2Update
    case smartLightV2FactoryReset
    case smartLightV2faq
    case smartLightV2faqQ1
    case smartLightV2faqQ2
    case smartLightV2faqQ3
    case smartLightV2faqQ4
    case smartLightV2faqQ5
    case smartLightV2faqA1
    case smartLightV2faqA2
    case smartLightV2faqA3
    case smartLightV2faqA4
    case smartLightV2faqA5
    case resetFactorySettings
    case smartLightV2ResetFactorySettingsDescription
    case smartLightV2FirmwareUpdateText
    case userManual
    case smartLightV2UserManualQ1
    case smartLightV2UserManualQ2
    case smartLightV2UserManualQ3
    case smartLightV2UserManualQ4
    case smartLightV2UserManualQ5
    case smartLightV2UserManualQ6
    case smartLightV2UserManualQ7
    case smartLightV2UserManualQ8
    case smartLightV2UserManualQ9
    case smartLightV2UserManualA1
    case smartLightV2UserManualA2
    case smartLightV2UserManualA3
    case smartLightV2UserManualA4
    case smartLightV2UserManualA5
    case smartLightV2UserManualA6
    case smartLightV2UserManualA7
    case smartLightV2UserManualA8
    case smartLightV2UserManualA9
    case smartLightV2SpeakerBluetoothConnect
    case connectBluetooth
    case notNow
    case smartLightV2LightingSettings
    case smartLightV2TimeSettings
    case smartLightV2TimeSettingsDescription
    case smartLightV2TimeSettingHide
    case smartLightV2TimeSettingHidePeriod
    case smartLightV2SleepAssistant
    case smartLightV2SleepAssistantSwitch
    case sleepAssistantDuration
    case adjustTimeShowing
    case smartLightV2SleepAssistantSettings
    case smartLightV2SleepAssistantDuration
    case smartLightV2SleepAssistantDurationText
    case smartLightV2SleepAssistantDurationButton
    case playingMusic
    case smartLightV2Light
    case nearestAlarm
    case weekdays
    case alarms
    case smartLightV2HowToCloseAlarm
    case smartLightV2HowToCloseAlarmTitle
    case smartLightV2HowToCloseAlarmTitleDescription
    case closeAlarm
    case closeAlarmDescription
    case firstMusic
    case secondMusic
    case thirdMusic
    case fourthMusic
    case fifthMusic
    case sixthMusic
    case alarmSound
    case musicTitleFirst
    case musicTitleFirstInfo1
    case musicTitleFirstInfo2
    case musicTitleFirstInfo3
    case musicTitleFirstInfo4
    case musicTitleSecond
    case musicTitleSecondInfo1
    case musicTitleSecondInfo2
    case musicTitleSecondInfo3
    case musicTitleSecondInfo4
    case musicTitleThird
    case musicTitleThirdInfo1
    case musicTitleThirdInfo2
    case musicTitleThirdInfo3
    case musicTitleThirdInfo4
    case musicList
    case versionAllreadyUpdated
    case mainModule
    case mcuModule
    case batteryLevel
    case battery
    case watchV2connectionError
    case control_smartlightv2_title
    case wifi_credentials_changing
    case wifi_credentials_change_success
    case wifi_credentials_change_failed
    case wifi_credentials_change_failed_desc
    
    //MARK: - IDO ERRORS
    case idoSuccess
    case idoUnrecoveredError
    case idoUnknown
    case idoNotFound
    case idoNotSupported
    case idoInvalidParameter
    case idoInvalidState
    case idoInvalidDataLength
    case idoInvalidFlags
    case idoInvalidData
    case idoWrongDataSize
    case idoTimeout
    case idoTimeoutToast
    case timeoutOperation
    case idoEmptyData
    case idoForbidden
    case idoSystemBusy
    case idoBatteryTooLow
    case idoBluetoothDisconnect
    case idoBluetoothDisconnectCurrentOTA
    case idoBluetoothDisconnectDeviceSyncing
    case idoUnorganizedSpace
    case idoSpaceBeingOrganized
    case idoModelDataError
    case idoCurrentOTA
    case idoSyncingDeviceError
    case idoWrongAuthCode
    case idoPairingCancelled
    case idoPairingUnknownTimeout
    case idoPairingReconnectionFailed
    case idoOTAReconnectionFailed
    case idoFileNotExist
    case idoFileTransferFailed
    case idoWrongAlarmId
    case idoPairingTimeout
    case idoConfigError
    case idoDataMigrationError
    case idoBluetoothPairingError
    case idoDeviceNotBound
    case idoGPSRunning
    case idoSyncItemError
    case idoTransferringFileError
    case idoMethodDeprecated
    case idoWrongAlarmName
    case idoEncryptedAuthCode
    case idoWriteDataError
    case idoSyncDataEmptyError
    case idoSyncGPSDataEmptyError
    case idoWatchfaceFeatureUnsupported
    case idoWatchfaceLoadError
    case idoWatchfaceInstallError
    case idoWatcheNotEnoughSpaceError
    //MARK: - IDO ERRORS - WATCHFACE
    case idoWFInitializing
    case idoWFCheckingSpace
    case idoWFCleanupSpace
    case idoWFDownloading
    case idoWFTransferring
    case idoWFActivating
    case idoWFInstalled
}
