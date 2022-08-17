type t = {
  list: array<string>,
  mutable overflow: bool,
  mutable tone: int,
}

type list = {
  list: array<(int, int, string)>,
  mutable tone: int,
}

let dbDict = ["1", "#1", "2", "#2", "3", "4", "#4", "5", "#5", "6", "#6", "7"]

let replacer = str =>
  str
  ->Js.String2.replaceByRe(%re("/【/g"), "[")
  ->Js.String2.replaceByRe(%re("/（/g"), "(")
  ->Js.String2.replaceByRe(%re("/】/g"), "]")
  ->Js.String2.replaceByRe(%re("/）/g"), ")")

let parsefromString = (~operator, str) => {
  let arr = str->Js.String2.split("")
  let result = arr->Js.Array2.reducei(
    (result, char, i) => {
      let tone = switch char {
      | "[" =>
        if i > 0 && arr[i - 1] == "[" {
          Some(2)
        } else {
          Some(1)
        }
      | "{" => Some(-2)
      | "(" => Some(-1)
      | ")" | "]" | "}" => Some(0)
      | "#" => None
      | val => {
          let index = dbDict->Js.Array2.indexOf(
            if i > 0 && arr[i - 1] == "#" {
              "#" ++ char
            } else {
              char
            },
          )
          let item = if index > -1 {
            switch operator {
            | #RisingTone => (index > 10 ? result.tone + 1 : result.tone, (index + 1)->mod(12), val)
            | #FallingTone => (
                index < 1 ? result.tone - 1 : result.tone,
                (index + 11)->mod(12),
                val,
              )
            | _ => (result.tone, index, val)
            }
          } else {
            (result.tone, index, val)
          }

          let _ = result.list->Js.Array2.push(item)
          None
        }
      }
      let _ = switch tone {
      | Some(tone) => result.tone = tone
      | None => ()
      }
      result
    },
    {
      tone: 0,
      list: [],
    },
  )
  switch result {
  | {list} => list
  }
}

let getListString = source => {
  let signMap = Belt.HashMap.Int.make(~hintSize=3)
  signMap->Belt.HashMap.Int.set(-2, ("{", "}"))
  signMap->Belt.HashMap.Int.set(-1, ("(", ")"))
  signMap->Belt.HashMap.Int.set(1, ("[", "]"))
  signMap->Belt.HashMap.Int.set(2, ("[[", "]]"))

  source->Js.Array2.reducei(
    (result: t, (tone, value, char), index) => {
      let pushSign = (tone, picker) => {
        let _ = switch signMap->Belt.HashMap.Int.get(tone) {
        | Some(val) => result.list->Js.Array2.push(picker(val))
        | None => -1
        }
      }
      if tone != result.tone {
        pushSign(result.tone, ((_a, b)) => b)
        pushSign(tone, ((a, _b)) => a)
      }
      let char = if value > -1 {
        dbDict[value]
      } else {
        char
      }
      let _ = result.list->Js.Array2.push(char)
      if index === source->Js.Array2.length - 1 {
        pushSign(tone, ((_a, b)) => b)
      }

      result.tone = tone
      if result.overflow == false {
        result.overflow = tone > 2 || tone < -2
      }
      result
    },
    {
      tone: 0,
      overflow: false,
      list: [],
    },
  )
}

let modifiedTone = (str, operator) => {
  let {list, overflow} = str->replacer->parsefromString(~operator)->getListString
  if overflow {
    str
  } else {
    list->Js.Array2.joinWith("")
  }
}
