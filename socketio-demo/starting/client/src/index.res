switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<React.StrictMode> <App /> </React.StrictMode>, root)
| None => Js.log("Error: could not find react element")
}

// Snowpack hot module reload
open Snowpack
if hot {
  accept()
}
