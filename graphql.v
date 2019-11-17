module graphql

import strconv
// import http
import json

pub struct VarValue {
	typ VarType
	value string
}

pub enum VarType {
	string = 0
	number = 1
	bool = 2	
}

struct Client {
	url string
}

struct GraphqlRequest {
	query string
	pub mut:
	headers map[string]string
	vars map[string]VarValue
}

struct IntVar {
	key string
	value int
}

struct BooleanVar {
	key string
	value bool
}

struct StringVar {
	key string
	value string
}

pub fn new_client(url string) &Client {
	return &Client{
		url: url
	}
}

// pub fn (c &Client) run(r &GraphqlRequest) string {
// 	vars := ""
// 	for key, val in r.vars {

// 	}
// 	req := http.new_GraphqlRequest("POST", c.url)
// 	req.add_header("")
// }

pub fn new_request(q string) &GraphqlRequest {
	return &GraphqlRequest {
		query: q
	}
}

pub fn (r mut GraphqlRequest) set_header(key, value string) {
	r.headers[key] = value
}

pub fn (r mut GraphqlRequest) set_var(key string, value VarValue) {
	r.vars[key] = value
}

fn parse_var(key string, _type VarValue) string {
	if _type.typ == VarType.string {
		stru := &StringVar {
			key: key,
			value: _type.value
		}

		return json.encode(stru)
	} else if _type.typ == VarType.number {
		stru := &IntVar {
			key: key,
			value: strconv.atoi(_type.value)
		}

		return json.encode(stru)
	} else if _type.typ == VarType.bool {
		stru := &BooleanVar {
			key: key,
			value: _type.value == "true"
		}

		return json.encode(stru)
	}

	return ""
}

fn main() {
	println(parse_var("hi", VarValue{typ: VarType.string, value: "hi"}))
}