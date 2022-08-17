module Button = {
  @react.component
  let make = (~onClick: option<'t>=?, ~children, ~className="") => {
    let onClick = switch onClick {
    | Some(fn) => fn
    | None => _ => ()
    }
    let className =
      className ++ " w-8 h-8 group flex justify-center items-center rounded-md bg-blue-500 text-white text-sm font-medium cursor-pointer shadow-sm hover:bg-blue-400"
    <button className onClick> {children} </button>
  }
}

@get
external value: 't => string = "value"

@react.component
let make = () => {
  let (state, setState) = React.useState(_ => "")

  let onClick = (operator, _) => {
    setState(_prev => state->DBParser.modifiedTone(operator))
  }
  let onChange = e => {
    ReactEvent.Form.preventDefault(e)
    let value = ReactEvent.Form.target(e)["value"]
    setState(_prev => value)
  }
  <div>
    <textarea
      value=state
      onChange
      className="absolute right-0 top-0 bottom-0 left-0 outline-0 p-4"
      placeholder="Sheet music"
    />
    <div className="flex absolute top-4 right-4">
      <Button className="mr-4" onClick={onClick(#RisingTone)}> {"+"->React.string} </Button>
      <Button onClick={onClick(#FallingTone)}> {"-"->React.string} </Button>
    </div>
  </div>
}
