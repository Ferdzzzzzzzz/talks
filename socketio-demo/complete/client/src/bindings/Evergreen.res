// unfold is a utility function that repackages optional arguments into
// a new option.
let unfold = (x: option<'a>, f: 'a => 'b) =>
  switch x {
  | None => None
  | Some(x) => Some(x->f)
  }

type color =
  | Gray900
  | Gray800
  | Gray700
  | Gray600
  | Gray500
  | Gray400
  | Gray300
  | Gray200
  | Gray100
  | Gray90
  | Gray75
  | Gray50
  | Blue900
  | Blue800
  | Blue700
  | Blue600
  | Blue500
  | Blue400
  | Blue300
  | Blue200
  | Blue100
  | Blue50
  | Blue25
  | Red700
  | Red600
  | Red500
  | Red300
  | Red100
  | Red25
  | Green900
  | Green800
  | Green700
  | Green600
  | Green500
  | Green400
  | Green300
  | Green200
  | Green100
  | Green25
  | Orange700
  | Orange500
  | Orange100
  | Orange25
  | Purple600
  | Purple100
  | Teal800
  | Teal100
  | Yellow800
  | Yellow100
  | Muted
  | Default
  | Dark
  | Selected
  | Tint1
  | Tint2
  | Overlay
  | YellowTint
  | GreenTint
  | OrangeTint
  | RedTint
  | BlueTint
  | PurpleTint
  | TealTint

let colorToStr = color =>
  switch color {
  | Gray900 => "gray900"
  | Gray800 => "gray800"
  | Gray700 => "gray700"
  | Gray600 => "gray600"
  | Gray500 => "gray500"
  | Gray400 => "gray400"
  | Gray300 => "gray300"
  | Gray200 => "gray200"
  | Gray100 => "gray100"
  | Gray90 => "gray90"
  | Gray75 => "gray75"
  | Gray50 => "gray50"
  | Blue900 => "blue900"
  | Blue800 => "blue800"
  | Blue700 => "blue700"
  | Blue600 => "blue600"
  | Blue500 => "blue500"
  | Blue400 => "blue400"
  | Blue300 => "blue300"
  | Blue200 => "blue200"
  | Blue100 => "blue100"
  | Blue50 => "blue50"
  | Blue25 => "blue25"
  | Red700 => "red700"
  | Red600 => "red600"
  | Red500 => "red500"
  | Red300 => "red300"
  | Red100 => "red100"
  | Red25 => "red25"
  | Green900 => "green900"
  | Green800 => "green800"
  | Green700 => "green700"
  | Green600 => "green600"
  | Green500 => "green500"
  | Green400 => "green400"
  | Green300 => "green300"
  | Green200 => "green200"
  | Green100 => "green100"
  | Green25 => "green25"
  | Orange700 => "orange700"
  | Orange500 => "orange500"
  | Orange100 => "orange100"
  | Orange25 => "orange25"
  | Purple600 => "purple600"
  | Purple100 => "purple100"
  | Teal800 => "teal800"
  | Teal100 => "teal100"
  | Yellow800 => "yellow800"
  | Yellow100 => "yellow100"
  | Muted => "muted"
  | Default => "default"
  | Dark => "dark"
  | Selected => "selected"
  | Tint1 => "tint1"
  | Tint2 => "tint2"
  | Overlay => "overlay"
  | YellowTint => "yellowTint"
  | GreenTint => "greenTint"
  | OrangeTint => "orangeTint"
  | RedTint => "redTint"
  | BlueTint => "blueTint"
  | PurpleTint => "purpleTint"
  | TealTint => "tealTint"
  }

module Button = {
  type appearance =
    | Default
    | Minimal
    | Primary

  let appearanceToStr = appearance =>
    switch appearance {
    | Default => "default"
    | Minimal => "minimal"
    | Primary => "primary"
    }

  type intent =
    | NoIntent
    | Success
    | Danger

  let intentToStr = intent =>
    switch intent {
    | NoIntent => "none"
    | Success => "success"
    | Danger => "danger"
    }

  type size =
    | Sm
    | Md
    | Lg

  let sizeToStr = size =>
    switch size {
    | Sm => "small"
    | Md => "medium"
    | Lg => "large"
    }

  module Binding = {
    @react.component @module("evergreen-ui")
    external make: (
      ~appearance: option<string>=?,
      ~size: option<string>=?,
      ~onClick: option<ReactEvent.Mouse.t => unit>=?,
      ~isLoading: option<bool>=?,
      ~isActive: option<bool>=?,
      ~iconBefore: option<React.element>=?,
      ~iconAfter: option<React.component<_>>=?,
      ~disabled: option<bool>=?,
      ~className: option<string>=?,
      ~intent: option<string>=?,
      ~children: string,
    ) => React.element = "Button"
  }

  @react.component
  let make = (
    ~appearance: option<appearance>=?,
    ~size: option<size>=?,
    ~isLoading: option<bool>=?,
    ~isActive: option<bool>=?,
    ~iconBefore: option<React.element>=?,
    ~iconAfter: option<React.component<_>>=?,
    ~disabled: option<bool>=?,
    ~onClick: option<ReactEvent.Mouse.t => unit>=?,
    ~className: option<string>=?,
    ~intent: option<intent>=?,
    ~children: string,
  ) => {
    let appearance = appearance->unfold(appearanceToStr)
    let size = size->unfold(sizeToStr)
    let intent = intent->unfold(intentToStr)

    <Binding
      ?appearance
      ?size
      ?intent
      ?isLoading
      ?isActive
      ?iconBefore
      ?iconAfter
      ?disabled
      ?className
      ?onClick>
      children
    </Binding>
  }
}

module IconButton = {
  type appearance =
    | Default
    | Minimal
    | Primary

  let appearanceToStr = appearance =>
    switch appearance {
    | Default => "default"
    | Minimal => "minimal"
    | Primary => "primary"
    }

  type intent =
    | NoIntent
    | Success
    | Danger

  let intentToStr = intent =>
    switch intent {
    | NoIntent => "none"
    | Success => "success"
    | Danger => "danger"
    }

  type size =
    | Sm
    | Md
    | Lg

  let sizeToStr = size =>
    switch size {
    | Sm => "small"
    | Md => "medium"
    | Lg => "large"
    }

  module Binding = {
    @react.component @module("evergreen-ui")
    external make: (
      ~appearance: option<string>=?,
      ~size: option<string>=?,
      ~icon: React.element,
      ~isLoading: option<bool>=?,
      ~isActive: option<bool>=?,
      ~onClick: ReactEvent.Mouse.t => unit,
      ~disabled: option<bool>=?,
      ~className: option<string>=?,
      ~intent: option<string>=?,
    ) => React.element = "IconButton"
  }

  @react.component
  let make = (
    ~appearance: option<appearance>=?,
    ~size: option<size>=?,
    ~isLoading: option<bool>=?,
    ~icon: React.element,
    ~isActive: option<bool>=?,
    ~disabled: option<bool>=?,
    ~onClick: ReactEvent.Mouse.t => unit,
    ~className: option<string>=?,
    ~intent: option<intent>=?,
  ) => {
    let appearance = appearance->unfold(appearanceToStr)
    let size = size->unfold(sizeToStr)
    let intent = intent->unfold(intentToStr)

    <Binding ?appearance ?size ?intent ?isLoading ?isActive ?disabled ?className onClick icon />
  }
}

module CornerDialog = {
  type renderProps = {close: unit => unit}

  type intent =
    | NoIntent
    | Success
    | Warning
    | Danger

  type children =
    | Node(React.element)
    | Str(string)
    | Render(renderProps => React.element)

  let intentToStr = intent =>
    switch intent {
    | NoIntent => "none"
    | Success => "success"
    | Warning => "warning"
    | Danger => "danger"
    }

  module BindingRenderProps = {
    @react.component @module("evergreen-ui")
    external make: (
      ~children: renderProps => React.element,
      ~intent: option<string>=?,
      ~isShown: option<bool>=?,
      ~title: string,
      ~onCloseComplete: option<unit => unit>=?,
      ~onOpenComplete: option<unit => unit>=?,
      ~hasFooter: option<bool>=?,
      ~onConfirm: option<unit => unit>=?,
      ~confirmLabel: option<string>=?,
      ~hasCancel: option<bool>=?,
      ~hasClose: option<bool>=?,
      ~onCancel: option<(unit => unit) => unit>=?,
      ~cancelLabel: option<string>=?,
      ~width: option<int>=?,
    ) => React.element = "CornerDialog"
  }

  module BindingStr = {
    @react.component @module("evergreen-ui")
    external make: (
      ~children: string,
      ~intent: option<string>=?,
      ~isShown: option<bool>=?,
      ~title: string,
      ~onCloseComplete: option<unit => unit>=?,
      ~onOpenComplete: option<unit => unit>=?,
      ~hasFooter: option<bool>=?,
      ~onConfirm: option<unit => unit>=?,
      ~confirmLabel: option<string>=?,
      ~hasCancel: option<bool>=?,
      ~hasClose: option<bool>=?,
      ~onCancel: option<(unit => unit) => unit>=?,
      ~cancelLabel: option<string>=?,
      ~width: option<int>=?,
    ) => React.element = "CornerDialog"
  }

  module BindingNode = {
    @react.component @module("evergreen-ui")
    external make: (
      ~children: React.element,
      ~intent: option<string>=?,
      ~isShown: option<bool>=?,
      ~title: string,
      ~onCloseComplete: option<unit => unit>=?,
      ~onOpenComplete: option<unit => unit>=?,
      ~hasFooter: option<bool>=?,
      ~onConfirm: option<unit => unit>=?,
      ~confirmLabel: option<string>=?,
      ~hasCancel: option<bool>=?,
      ~hasClose: option<bool>=?,
      ~onCancel: option<(unit => unit) => unit>=?,
      ~cancelLabel: option<string>=?,
      ~width: option<int>=?,
    ) => React.element = "CornerDialog"
  }

  @react.component
  let make = (
    ~children: children,
    ~intent: option<intent>=?,
    ~isShown: option<bool>=?,
    ~title: string,
    ~onCloseComplete: option<unit => unit>=?,
    ~onOpenComplete: option<unit => unit>=?,
    ~hasFooter: option<bool>=?,
    ~onConfirm: option<unit => unit>=?,
    ~confirmLabel: option<string>=?,
    ~hasCancel: option<bool>=?,
    ~hasClose: option<bool>=?,
    ~onCancel: option<(unit => unit) => unit>=?,
    ~cancelLabel: option<string>=?,
    ~width: option<int>=?,
  ) => {
    let intent = intent->unfold(intentToStr)

    switch children {
    | Node(children) =>
      <BindingNode
        ?intent
        ?isShown
        ?onCloseComplete
        title
        ?onOpenComplete
        ?hasFooter
        ?onConfirm
        ?confirmLabel
        ?hasCancel
        ?hasClose
        ?onCancel
        ?cancelLabel
        ?width>
        children
      </BindingNode>
    | Str(children) =>
      <BindingStr
        ?intent
        ?isShown
        ?onCloseComplete
        title
        ?onOpenComplete
        ?hasFooter
        ?onConfirm
        ?confirmLabel
        ?hasCancel
        ?hasClose
        ?onCancel
        ?cancelLabel
        ?width>
        children
      </BindingStr>
    | Render(children) =>
      <BindingRenderProps
        ?intent
        ?isShown
        ?onCloseComplete
        title
        ?onOpenComplete
        ?hasFooter
        ?onConfirm
        ?confirmLabel
        ?hasCancel
        ?hasClose
        ?onCancel
        ?cancelLabel
        ?width>
        children
      </BindingRenderProps>
    }
  }
}

module Heading = {
  type size =
    | Xs3
    | Xs2
    | Xs
    | Sm
    | Md
    | Lg
    | Xl
    | Xl2
    | Xl3

  // returns a tuple with (size, marginBottom)
  let sizeToInt = size =>
    switch size {
    | Xs3 => (100, 16)
    | Xs2 => (200, 16)
    | Xs => (300, 16)
    | Sm => (400, 16)
    | Md => (500, 24)
    | Lg => (600, 28)
    | Xl => (700, 40)
    | Xl2 => (800, 40)
    | Xl3 => (900, 52)
    }

  module Binding = {
    @react.component @module("evergreen-ui")
    external make: (~children: string, ~size: int, ~marginBottom: int) => React.element = "Heading"
  }

  @react.component
  let make = (~text: string, ~size: option<size>=?) => {
    let (size, marginBottom) = switch size {
    | None => Md->sizeToInt
    | Some(size) => size->sizeToInt
    }

    <Binding size marginBottom> text </Binding>
  }
}

module Text = {
  type size =
    | Sm
    | Md
    | Lg

  let sizeToInt = size =>
    switch size {
    | Sm => 300
    | Md => 400
    | Lg => 500
    }

  module Binding = {
    @react.component @module("evergreen-ui")
    external make: (
      ~children: string,
      ~size: option<int>=?,
      ~color: option<string>=?,
    ) => React.element = "Text"
  }

  @react.component
  let make = (~size: option<size>=?, ~children: string, ~muted: option<bool>=?) => {
    let size = size->unfold(sizeToInt)

    let color = muted->unfold(m =>
      switch m {
      | false => ""
      | true => "muted"
      }
    )

    <Binding ?color ?size> children </Binding>
  }
}

module Alert = {
  type children =
    | Str(string)
    | Elem(React.element)

  type appearance =
    | Default
    | Card

  type intent =
    | NoIntent
    | Success
    | Warning
    | Danger

  let intentToStr = intent => {
    switch intent {
    | NoIntent => "none"
    | Success => "success"
    | Warning => "warning"
    | Danger => "danger"
    }
  }

  let appearanceToStr = appearance =>
    switch appearance {
    | Default => "default"
    | Card => "card"
    }

  type onRemove = unit => unit

  module Binding = {
    @react.component @module("evergreen-ui")
    external make: (
      ~children: React.element,
      ~intent: string=?,
      ~hasIcon: bool=?,
      ~isRemoveable: bool=?,
      ~onRemove: onRemove=?,
      ~title: string,
      ~appearance: string=?,
    ) => React.element = "Alert"
  }

  @react.component
  let make = (
    ~children: option<children>=?,
    ~intent: option<intent>=?,
    ~hasIcon: option<bool>=?,
    ~isRemoveable: option<bool>=?,
    ~onRemove: option<onRemove>=?,
    ~title: string,
    ~appearance: option<appearance>=?,
  ) => {
    let intent = intent->unfold(intentToStr)
    let appearance = appearance->unfold(appearanceToStr)

    <Binding ?intent ?hasIcon ?isRemoveable ?onRemove title ?appearance>
      {switch children {
      | None => React.null
      | Some(someChild) =>
        switch someChild {
        | Elem(elem) => elem
        | Str(str) => React.string(str)
        }
      }}
    </Binding>
  }
}

module Table = {
  module Head = {}
  module Body = {}
  module Row = {}
  module Cell = {}
  module TextCell = {}
  module HeaderCell = {}
  module TextHeaderCell = {}
  module SearchHeaderCell = {}

  @react.component @module("evergreen-ui")
  external make: (~children: React.element) => React.element = "Table"
}

type toaster
type toasterOptions = {description: string}

@module("evergreen-ui") external toaster: toaster = "toaster"

@send external success: (toaster, string, toasterOptions) => unit = "success"
@send external notify: (toaster, string, toasterOptions) => unit = "notify"
@send external warning: (toaster, string, toasterOptions) => unit = "warning"
@send external danger: (toaster, string, toasterOptions) => unit = "danger"
@send external closeAll: toaster => unit = "success"

// Make this API Happen
// toaster
//   -> success("Title")
//   -> WithDescription("Something over here")
//   -> withId("SomeId")

module Dialog = {
  type renderProps = {close: unit => unit}

  type intent =
    | NoIntent
    | Success
    | Warning
    | Danger

  let intentToStr = intent =>
    switch intent {
    | NoIntent => "none"
    | Success => "success"
    | Warning => "warning"
    | Danger => "danger"
    }

  module Binding = {
    @react.component @module("evergreen-ui")
    external make: (
      ~children: renderProps => React.element,
      ~intent: option<string>=?,
      ~isShown: option<bool>=?,
      ~title: option<React.element>=?,
      ~hasHeader: option<bool>=?,
      ~header: option<renderProps => React.element>=?,
      ~hasFooter: option<bool>=?,
      ~footer: option<renderProps => React.element>=?,
      ~hasCancel: option<bool>=?,
      ~hasClose: option<bool>=?,
      ~onCloseComplete: option<unit => unit>=?,
      ~onOpenComplete: option<unit => unit>=?,
      ~onConfirm: option<renderProps => unit>=?,
      ~onConfirmLabel: option<string>=?,
      ~isConfirmLoading: option<bool>=?,
      ~isConfirmDisabled: option<bool>=?,
      ~onCancel: option<renderProps => unit>=?,
      ~cancelLabel: option<string>=?,
      ~shouldCloseOnOverlayClick: option<bool>=?,
      ~shouldCloseOnEscapePress: option<bool>=?,
      ~width: option<int>=?,
      ~topOffset: option<int>=?,
      ~sideOffset: option<int>=?,
      ~minHeightContent: option<int>=?,
      ~preventBodyScrolling: option<bool>=?,
    ) => React.element = "Dialog"
  }

  @react.component
  let make = (
    ~children: renderProps => React.element,
    ~intent: option<intent>=?,
    ~isShown: option<bool>=?,
    ~title: option<React.element>=?,
    ~hasHeader: option<bool>=?,
    ~header: option<renderProps => React.element>=?,
    ~hasFooter: option<bool>=?,
    ~footer: option<renderProps => React.element>=?,
    ~hasCancel: option<bool>=?,
    ~hasClose: option<bool>=?,
    ~onCloseComplete: option<unit => unit>=?,
    ~onOpenComplete: option<unit => unit>=?,
    ~onConfirm: option<renderProps => unit>=?,
    ~onConfirmLabel: option<string>=?,
    ~isConfirmLoading: option<bool>=?,
    ~isConfirmDisabled: option<bool>=?,
    ~onCancel: option<renderProps => unit>=?,
    ~cancelLabel: option<string>=?,
    ~shouldCloseOnOverlayClick: option<bool>=?,
    ~shouldCloseOnEscapePress: option<bool>=?,
    ~width: option<int>=?,
    ~topOffset: option<int>=?,
    ~sideOffset: option<int>=?,
    ~minHeightContent: option<int>=?,
    ~preventBodyScrolling: option<bool>=?,
  ) => {
    let intent = intent->unfold(intentToStr)

    <Binding
      ?intent
      ?isShown
      ?title
      ?hasHeader
      ?header
      ?hasFooter
      ?footer
      ?hasCancel
      ?hasClose
      ?onCloseComplete
      ?onOpenComplete
      ?onConfirm
      ?onConfirmLabel
      ?isConfirmLoading
      ?isConfirmDisabled
      ?onCancel
      ?cancelLabel
      ?shouldCloseOnOverlayClick
      ?shouldCloseOnEscapePress
      ?width
      ?topOffset
      ?sideOffset
      ?minHeightContent
      ?preventBodyScrolling>
      children
    </Binding>
  }
}

module Popover = {
  type contentRenderProps = {close: unit => unit}
  type childrenRenderProps = {
    toggle: unit => unit,
    // getRef: unit => React.ref<'a>, //not sure how this works
    isShown: bool,
  }

  type posObj
  type pos

  @module("evergreen-ui") external posObj: posObj = "Position"

  @get external top: posObj => pos = "TOP"
  @get external topRight: posObj => pos = "TOP_RIGHT"
  @get external topLeft: posObj => pos = "TOP_LEFT"

  @get external bottom: posObj => pos = "BOTTOM"
  @get external bottomRight: posObj => pos = "BOTTOM_RIGHT"
  @get external bottomLeft: posObj => pos = "BOTTOM_LEFT"

  @get external right: posObj => pos = "RIGHT"
  @get external left: posObj => pos = "LEFT"

  type position =
    | Top
    | TopLeft
    | TopRight
    | Bottom
    | BottomLeft
    | BottomRight
    | Left
    | Right

  let positionToPos = position =>
    switch position {
    | Top => posObj->top
    | TopLeft => posObj->topLeft
    | TopRight => posObj->topRight
    | Bottom => posObj->bottom
    | BottomLeft => posObj->bottomLeft
    | BottomRight => posObj->bottomRight
    | Left => posObj->left
    | Right => posObj->right
    }

  type trigger =
    | Click
    | Hover

  type children =
    | Func(childrenRenderProps => React.element)
    | Elem(React.element)

  let triggerToStr = trigger =>
    switch trigger {
    | Click => "click"
    | Hover => "hover"
    }

  module FunctionBinding = {
    @react.component @module("evergreen-ui")
    external make: (
      ~position: option<pos>=?,
      ~isShown: option<bool>=?,
      ~trigger: option<string>=?,
      ~content: contentRenderProps => React.element,
      ~children: childrenRenderProps => React.element,
      ~display: option<string>=?,
      ~minWidth: option<int>=?,
      ~minHeight: option<int>=?,
      ~animationDuration: option<int>=?,
      ~onOpen: option<unit => unit>=?,
      ~onClose: option<unit => unit>=?,
      ~onOpenComplete: option<unit => unit>=?,
      ~onCloseComplete: option<unit => unit>=?,
      ~onBodyClick: option<unit => unit>=?,
      ~bringFocusInside: option<bool>=?,
      ~shouldCloseOnExternalClick: option<bool>=?,
    ) => React.element = "Popover"
  }

  module ElemBinding = {
    @react.component @module("evergreen-ui")
    external make: (
      ~position: option<pos>=?,
      ~isShown: option<bool>=?,
      ~trigger: option<string>=?,
      ~content: contentRenderProps => React.element,
      ~children: React.element,
      ~display: option<string>=?,
      ~minWidth: option<int>=?,
      ~minHeight: option<int>=?,
      ~animationDuration: option<int>=?,
      ~onOpen: option<unit => unit>=?,
      ~onClose: option<unit => unit>=?,
      ~onOpenComplete: option<unit => unit>=?,
      ~onCloseComplete: option<unit => unit>=?,
      ~onBodyClick: option<unit => unit>=?,
      ~bringFocusInside: option<bool>=?,
      ~shouldCloseOnExternalClick: option<bool>=?,
    ) => React.element = "Popover"
  }

  @react.component
  let make = (
    ~position: option<position>=?,
    ~isShown: option<bool>=?,
    ~trigger: option<trigger>=?,
    ~content: contentRenderProps => React.element,
    ~children: children,
    ~display: option<string>=?,
    ~minWidth: option<int>=?,
    ~minHeight: option<int>=?,
    ~animationDuration: option<int>=?,
    ~onOpen: option<unit => unit>=?,
    ~onClose: option<unit => unit>=?,
    ~onOpenComplete: option<unit => unit>=?,
    ~onCloseComplete: option<unit => unit>=?,
    ~onBodyClick: option<unit => unit>=?,
    ~bringFocusInside: option<bool>=?,
    ~shouldCloseOnExternalClick: option<bool>=?,
  ) => {
    let trigger = trigger->unfold(triggerToStr)
    let position = position->unfold(positionToPos)

    switch children {
    | Func(children) =>
      <FunctionBinding
        content
        ?position
        ?isShown
        ?trigger
        ?display
        ?minWidth
        ?minHeight
        ?animationDuration
        ?onOpen
        ?onClose
        ?onOpenComplete
        ?onCloseComplete
        ?onBodyClick
        ?bringFocusInside
        ?shouldCloseOnExternalClick>
        children
      </FunctionBinding>
    | Elem(children) =>
      <ElemBinding
        content
        ?position
        ?isShown
        ?trigger
        ?display
        ?minWidth
        ?minHeight
        ?animationDuration
        ?onOpen
        ?onClose
        ?onOpenComplete
        ?onCloseComplete
        ?onBodyClick
        ?bringFocusInside
        ?shouldCloseOnExternalClick>
        children
      </ElemBinding>
    }
  }
}

module Pane = {
  type alignItems = Stretch | Center | FlexStart | FlexEnd

  let alignToStr = align =>
    switch align {
    | Stretch => "stretch"
    | Center => "center"
    | FlexStart => "flex-start"
    | FlexEnd => "flex-end"
    }

  type elevation =
    | No
    | Sm
    | Md
    | Lg
    | Xl

  let elevationToInt = elevation =>
    switch elevation {
    | No => 0
    | Sm => 1
    | Md => 2
    | Lg => 3
    | Xl => 4
    }

  module Binding = {
    @react.component @module("evergreen-ui")
    external make: (
      ~alignItems: option<string>=?,
      ~background: option<string>=?,
      ~borderRadius: option<int>=?,
      ~display: option<string>=?,
      ~elevation: option<int>=?,
      ~flexDirection: option<string>=?,
      ~justifyContent: option<string>=?,
      ~children: React.element,
      ~height: option<int>=?,
      ~width: option<int>=?,
    ) => React.element = "Pane"
  }

  @react.component
  let make = (
    ~alignItems: option<alignItems>=?,
    ~background: option<color>=?,
    ~borderRadius: option<int>=?,
    ~children: React.element,
    ~display: option<string>=?,
    ~elevation: option<elevation>=?,
    ~flexDirection: option<string>=?,
    ~justifyContent: option<string>=?,
    ~height: option<int>=?,
    ~width: option<int>=?,
  ) => {
    let alignItems = alignItems->unfold(alignToStr)
    let background = background->unfold(colorToStr)
    let elevation = elevation->unfold(elevationToInt)

    <Binding
      ?alignItems
      ?background
      ?borderRadius
      ?height
      ?width
      ?display
      ?justifyContent
      ?flexDirection
      ?elevation>
      children
    </Binding>
  }
}

module StatusIndicator = {
  type intent =
    | NoIntent
    | Success
    | Warning
    | Danger

  let intentToStr = intent => {
    switch intent {
    | NoIntent => "none"
    | Success => "success"
    | Warning => "warning"
    | Danger => "danger"
    }
  }

  module Binding = {
    @react.component @module("evergreen-ui")
    external make: (
      ~children: option<React.element>=?,
      ~color: string,
      ~dotSize: option<int>=?,
    ) => React.element = "StatusIndicator"
  }

  module WithIntent = {
    @react.component
    let make = (~children: option<React.element>=?, ~intent: intent, ~dotSize: option<int>=?) => {
      let intent = intent->intentToStr

      switch children {
      | None => <Binding color=intent ?dotSize />
      | Some(children) => <Binding color=intent ?dotSize> children </Binding>
      }
    }
  }

  module WithColor = {
    let make = (~children: option<React.element>=?, ~dotSize: option<int>=?, ~color: color) => {
      let color = color->colorToStr

      switch children {
      | None => <Binding color ?dotSize />
      | Some(children) => <Binding color ?dotSize> children </Binding>
      }
    }
  }
}

module TextInput = {
  module Binding = {
    @react.component @module("evergreen-ui")
    external make: (
      ~className: option<string>=?,
      ~placeholder: option<string>=?,
      ~disabled: option<bool>=?,
      ~required: option<bool>=?,
      ~isInvalid: option<bool>=?,
      ~value: option<string>=?,
      ~spellCheck: option<bool>=?,
      ~width: option<string>=?,
      ~value: option<string>=?,
      ~onChange: option<ReactEvent.Form.t => unit>=?,
    ) => React.element = "TextInput"
  }

  @react.component
  let make = (
    ~className: option<string>=?,
    ~placeholder: option<string>=?,
    ~disabled: option<bool>=?,
    ~required: option<bool>=?,
    ~isInvalid: option<bool>=?,
    ~spellCheck: option<bool>=?,
    ~value: option<string>=?,
    ~width: option<string>=?,
    ~onChange: option<ReactEvent.Form.t => unit>=?,
  ) => {
    let width = switch width {
    | Some(str) => str
    | None => "100%"
    }

    <Binding
      ?className ?placeholder ?disabled ?required ?isInvalid ?spellCheck width ?onChange ?value
    />
  }
}

module TextInputField = {
  @react.component @module("evergreen-ui")
  external make: (
    ~label: string,
    ~description: option<string>=?,
    ~required: option<bool>=?,
    ~hint: option<string>=?,
    ~validationMessage: option<string>=?,
    ~onChange: option<ReactEvent.Synthetic.t => unit>=?,
  ) => React.element = "TextInput"
}
