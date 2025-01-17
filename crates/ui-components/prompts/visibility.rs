#![allow(non_snake_case)]
use db::Visibility;
use dioxus::prelude::*;
use primer_rsx::*;

#[derive(Props, PartialEq, Eq)]
pub struct Props<'a> {
    pub visibility: &'a Visibility,
}

pub fn VisLabel<'a>(cx: Scope<'a, Props<'a>>) -> Element {
    match cx.props.visibility {
        Visibility::Company => cx.render(rsx!(
            Label {
                class: "mr-2",
                label_color: LabelColor::Done,
                label_contrast: LabelContrast::Primary,
                "Company"
            }
        )),
        Visibility::Private => cx.render(rsx!(
            Label {
                class: "mr-2",
                label_color: LabelColor::Attention,
                "Private"
            }
        )),
        Visibility::Team => cx.render(rsx!(
            Label {
                class: "mr-2",
                label_color: LabelColor::Attention,
                "Team"
            }
        )),
    }
}
