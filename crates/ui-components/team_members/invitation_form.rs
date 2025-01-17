#![allow(non_snake_case)]
use dioxus::prelude::*;
use primer_rsx::*;

#[derive(Props, PartialEq, Eq)]
pub struct InvitationFormProps {
    submit_action: String,
}

pub fn InvitationForm(cx: Scope<InvitationFormProps>) -> Element {
    cx.render(rsx! {
        // The form to create an invitation
        form {
            method: "post",
            action: "{cx.props.submit_action}",
            Drawer {
                label: "Invite people into your team.",
                trigger_id: "create-invite-form",
                DrawerBody {
                    div {
                        class: "d-flex flex-column",
                        Input {
                            input_type: InputType::Email,
                            help_text: "The email address of the person you wish to invite",
                            required: true,
                            label: "Email",
                            name: "email"
                        }
                        Input {
                            input_type: InputType::Text,
                            help_text: "The first name of the person you wish to invite",
                            required: true,
                            label: "First Name",
                            name: "first_name"
                        }
                        Input {
                            input_type: InputType::Text,
                            help_text: "The last name of the person you wish to invite",
                            required: true,
                            label: "Last Name",
                            name: "last_name"
                        }
                        Alert {
                            alert_color: AlertColor::Success,
                            class: "mb-3",
                            label {
                                input {
                                    "type": "checkbox",
                                    name: "admin"
                                }
                                strong {
                                    class: "ml-2",
                                    "Invite as Team Administrator"
                                }
                            }
                            p {
                                class: "note",
                                "Team Administrators can invite new team members"
                            }
                        }
                        Alert {
                            alert_color: AlertColor::Success,
                            label {
                                input {
                                    "type": "checkbox",
                                    name: "negotiator"
                                }
                                strong {
                                    class: "ml-2",
                                    "Invite as Negotiator"
                                }
                            }
                            p {
                                class: "note",
                                "Negotiators can handle high interest events."
                            }
                        }
                    }
                }
                DrawerFooter {
                    Button {
                        button_type: ButtonType::Submit,
                        button_scheme: ButtonScheme::Primary,
                        "Send Invitation"
                    }
                }
            }
        }
    })
}
