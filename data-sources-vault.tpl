{
	"folders": {
		"Vault": {}
	},
    "connections": {
	{{- range $index, $rolename := secrets "database/roles" -}}
        {{- if $index -}},{{- end }}
		"postgres-jdbc-vault-{{ $index }}": {
            {{ with $role := secret (printf "database/roles/%s" $rolename) -}}
			"provider": "postgresql",
			"driver": "postgres-jdbc",
			"name": "{{ $rolename }}",
			"save-password": true,
			"folder": "Vault",
			"configuration": {
                {{ with $dbconfig := secret (printf "database/config/%s" $role.Data.db_name) -}}
				"url": "jdbc:{{ $dbconfig.Data.connection_details.connection_url | regexReplaceAll "://.*@" "://" | replaceAll "postgres://" "postgresql://" }}",
                {{ end -}}
				"configurationType": "URL",
                {{ if $rolename | contains "prod" -}}
                "type": "prod",
                {{ else -}}
				"type": "dev",
                {{ end -}}
				"provider-properties": {},
				"auth-model": "vault",
				"auth-properties": {
					"address": "{{env "VAULT_ADDR_GENERATED"}}",
					"secret": "database/creds/{{ $rolename }}"
				}
			}
            {{- end }}
		}
	{{ end -}}
	}
}
