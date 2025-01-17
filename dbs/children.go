package dbs

// dbs.children module
// Copyright (c) 2023 - Valentin Kuznetsov <vkuznet@gmail.com>
//
// nolint: gocyclo

// Children DBS API
//
//gocyclo:ignore
func (a *API) GetChild() error {
	var args []interface{}
	var conds []string
	var err error

	tmpl := make(map[string]any)
	tmpl["Owner"] = DBOWNER
	stm, err := LoadTemplateSQL("select_child", tmpl)
	if err != nil {
		return Error(err, LoadErrorCode, "", "dbs.children.GetChild")
	}
	if val, ok := a.Params["did"]; ok {
		if val != "" {
			conds, args = AddParam("did", "PDS.did", a.Params, conds, args)
		}
	}

	stm = WhereClause(stm, conds)

	// use generic query API to fetch the results from DB
	err = executeAll(a.Writer, a.Separator, stm, args...)
	if err != nil {
		return Error(err, QueryErrorCode, "fail to get child", "dbs.children.GetChild")
	}
	return nil
}
