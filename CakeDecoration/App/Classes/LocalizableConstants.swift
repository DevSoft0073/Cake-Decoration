//
//  LocalizableConstant.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit

struct LocalizableConstants {
    
    struct SuccessMessage {
        
        static let verificationMailSent = "verification_mail_sent"
        static let mailNotVerifiedYet = "mail_not_verified_yet"
        static let newPasswordSent = "new_password_sent"
        static let profileUpdated = "profile_updated"
        static let passwordChanged = "password_changed"
        static let addRequestSent = "add_request_sent"
        static let addRemoveFavUnfavStudio = "add_remove_fav_Unfav_studio"
        static let cancellationRequestSubmit = "your_cancellation_request_submit"
        static let rejectRequestSubmit = "your_rejection_request_submit"
        static let requestAccept = "your_request_submitted"
        static let timeSlotAdded = "time_slot_added"
        static let addedCard = "added_card_details"
        static let submitFeedback = "feedback_submit"
        static let blokDay = "blok_day"
    }
    
    struct Error {
        
        static let noNetworkConnection = "no_network_connection"
        static let sessionExpired = "session_expired"
        static let inProgress = "in_progress"
        static let cardDetailsNotValid = "please_enter_valid_card_details"
        static let accountDisable = "your_account_has_been_disable_please_contact_with_admin_for_more_detail"
        static let pendingStripeVerification = "pending_verification"
        static let maximumLimit = "add_limit"
    }
    
    struct ValidationMessage {
        
        //singup
        static let enterFirstName = "enter_first_name"
        static let enterLastName = "enter_last_name"
        static let selectBirthDate = "select_birth_date"
        static let selectGender = "select_gender"
        static let enterEmail = "Please enter email address."
        static let enterValidEmail = "Please enter valid email address."
        static let enterMobileNumber = "enter_mobile"
        static let enterValidMobileNumber = "enter_valid_mobile"
        static let enterPassword = "Please enter password."
        static let enterValidPassword = "Please enter valid password. Password should contain at least 8 characters, with at least 1 letter and 1 special character."
        static let agreeTermsAndConditions = "agree_with_terms_and_conditions"
        static let ageMustBeGreaterThen13 = "age_should_be_greater_then_13"
        
        //change password
        static let enterNewPassword = "enter_new_password"
        static let enterValidNewPassword = "enter_valid_new_password"
        static let enterRetypePassword = "enter_confirm_password"
        static let enterValidRetypePassword = "enter_valid_confirm_password"
        static let oldNewPasswordNotSame = "old_new_password_not_same"
        static let NewRetypePasswordNotMatch = "new_retype_password_not_match"
        
        //add request
        static let enterName = "enter_name"
        static let selectAddRequestPhoto = "select_add_request_photo"
        
        //signout
        static let confirmLogout = "confirm_logout"
        
        //studio profile
        
        static let enterFirstNameForStudio = "enter_first_name_studio"
        static let enterLastNameForStudio = "enter_last_name_studio"
        
        static let enterStudioName = "enter_studio_name"
        static let enterAddress = "enter_address"
        static let enterEmailForStudio = "enter_email"
        static let enterValidEmailForStudioProfile = "enter_valid_email"
        static let enterMobileNumberForStudioProfile = "enter_mobile"
        static let enterValidMobileNumberForStudioProfile = "enter_valid_mobile"
        static let enterStudioCredits = "enter_studio_credits"
        static let enterGenresYouSpeciliazeIn = "select_genres_you_specialized_in"
        static let selectMixingAndMastering = "selecte_yes_or_no"
        static let enterStudioEquipmentInfo = "enter_studio_equipment_info"
        static let enterStudioPricingBreakDown = "select_value_for_pricing_breakdown"
        
        //account Details
        
        static let enterAccountHolderName = "enter_account_holder_name"
        static let enterAccountNumber = "enter_account_number"
        static let enterRoutingNumber = "routing_number"
        static let enterSSN = "enter_SSN_number"
        static let enterFrontImage = "upload_front_image"
        static let enterBackImage = "upload_back_image"
        static let enterValidAccountNumber = "enter_valid_account_number"
        static let enterValidRoutingNumber = "enter_valid_routing_number"
        static let enterValidSSNNumber = "enter_valid_SSN_number"
        
        //record plant
        
        static let selectDate = "select_date"
        static let startTime = "start_time"
        static let endTime = "end_time"
        static let specialInstruction = "special_instruction"
        static let selectDay = "select_day"
        static let endTimeGreater = "end_time_must_be_greater_then_start_time"
        
        //feedback
        static let addTitle = "add_title"
        static let addDes = "add_description"
        
        
        //add payment method
        
        static let selectCardType = "select_card_type"
        static let enterCardNumber = "enter_card_number"
        static let enterValidCardNumber = "enter_valid_card_number"
        static let nameOnCard = "name_on_card"
        static let enterCVV = "enter_CVV"
        static let enterValidCVV = "enter_valid_CVV"
        static let enterExpirationDate = "enter_expiration_date"
        static let enterValidExpirationDate = "enter_valid_expiration_date"
        static let selectAnCard = "select_an_card"
        
        //request cancelatin and reject
        
        static let cancelllationReason = "give_reason_for_cancellation"
        static let rejectReason = "give_reason_for_rejection"
        
        //rating
        
        static let rating = "rating_should_not_be_empty."
        
    }
    
    struct Controller {
        
        struct Pages {
            
            static let pullMore = "pull_more"
            static let releaseToRefresh = "release_to_refresh"
            static let updating = "updating"
        }
        
        struct Home {
            static let title = "SC"
        }
        
        struct Sessions {
            
            static let title = "sessions"
            static let pending = "pending"
            static let confirmed = "confirmed"
            static let moreInfo = "more_info"
            static let payNow = "pay_now"
        }
        
        struct SessionsForStudioProfile {
            static let title = "sessions"
            static let pending = "pending"
            static let awating = "awating"
            static let confirmed = "confirmed"
            static let moreInfo = "more_info"
            static let payNow = "pay_now"
            
        }
        
        struct Messages {
            
            static let title = "messages"
        }
        
        struct Notifications {
            
            static let title = "notifications"
            static let noRecordsFound = "no_notifications_entry_found"
        }
        
        struct NotificationsForStudio {
            static let title = "notifications"
            static let noRecordFound = "no_notifications_entry_found"
        }
        
        struct NearByStudio {
            
            static let noSessionDataFound = "no_near_by_studio_available"
        }
        
        struct FavoriteStudios {
            
            static let noFavDataFound = "no_data_found"
        }
        
        struct SessionData {
            
            static let noRecordsFound = "no_data_found"
        }
        
        struct CardLising {
            
            static let noRecordsFound = "no_card_added"
            static let noCard = "no_card"
        }
        
        struct SessionDataForStudio {
            
            static let pending = "no_pending_data_found"
            static let awating = "no_awating_data_found"
            static let confirmed = "no_confirmed_data_found"
            static let noSelected = "no_session_selected"
            static let calendar = "no_data_available_for_this_date"
            static let blockedDates = "seleceted_dates_are_already_blocked"
            static let noDateBlocked = "no_date_blocked_for_this_month"
        }
        
        struct Profile {
            
            static let accountInformation = "account_information"
            static let paymentMethods = "payment_method"
            static let changePassword = "change_password"
            static let allowLocation = "allow_location"
            static let allowNotification = "allow_notification"
            static let favouriteStudios = "favourite_studios"
            static let bookingListing = "my_bookings"
            static let signupToStudioProfile = "signup_as_studio"
            static let switchToStudioProfile = "switch_to_studio"
            static let switchToArtistProfile = "switch_to_artist"
            static let termsAndCondition = "terms_and_condition"
            static let privecyPolicy = "Privacy Policy"
            static let cancellationPolicy = "cancellation_policy"
            static let logout = "sign_out"
        }
        
        struct StudioProfile {
            
            static let accountInformationForStudio = "account_information"
            static let paymentMethodsForStudio = "payment_method"
            static let changePasswordForStudio = "change_password"
            static let allowLocationForStudio = "allow_location"
            static let allowNotificationForStudio = "allow_notification"
            static let switchToArtistProfilForStudioe = "switch_to_artist"
            static let termsAndConditionForStudio = "terms_and_condition"
            static let cancellationPolicyForStudio = "cancellation_policy"
            static let addSlotTime = "add_slot_time"
        }
        
        struct StudioProfileForSupport {
            static let submitFeedbackForStudio = "submit_feedback"
            static let termsAndConditionForStudio = "terms_and_condition"
            static let cancellationPolicyForStudio = "cancellation_policy"
            static let logoutForStudio = "sign_out"
        }
        
        struct AccountInformation {
            static let accountName = "Account Name"
            static let accountEmail = "Account Email"
            static let accountMobileNumber = "Account Mobile Number"
            static let accountAddress = "Account Address"
        }
        
        struct AccountInformationSupport {
            static let accountStudioCredits = "Account Studio Credits"
            static let accountGenres = "Account Genres"
            static let accountStudioEquipment = "Account Studio Equipment"
            static let accountStudioPricing = "Account Studio Pricing"
        }
        
        struct SessionTitle {
            static let calendarSessionTitle = "Sessions"
        }
        
        struct EditProfile {
            
            static let title = "edit_profile"
        }
        
        struct Permissions {
            
            static let locationPermissionTitle = "location_permission_title"
            static let locationPermissionDescription = "location_permission_description"
            static let notificationPermissionTitle = "notification_permission_title"
            static let notificationPermissionDescription = "notification_permission_description"
        }
        
        struct Chat {
            
            static let no_message_available = "no_message_available"
        }
    }
}
