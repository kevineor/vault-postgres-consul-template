{
	"folders": {
		"Kpif": {}
	},
    "connections": {
	{{- range secrets "database/config" }}
		"postgres-jdbc-1867de06814-5ddd5e0defd9a07c": {
			"provider": "postgresql",
			"driver": "postgres-jdbc",
			"name": "postgres",
			"save-password": true,
			"folder": "Kpif",
			"configuration": {
                {{- with $dbconfig := secret (printf "database/config/%s" .) -}}
				"url": "{{ $dbconfig.Data.connection_details.connection_url | replaceAll "{{username}}:{{password}}@" "" }}",
                {{- end -}}
				"configurationType": "MANUAL",
                {{- if . | contains "prod" -}}
                "type": "prod",
                {{- else -}}
				"type": "dev",
                {{- end -}}
				"provider-properties": {},
				"auth-model": "vault",
				"auth-properties": {
					"address": "{{env "VAULT_ADDR"}}",
					"token_file": "/Users/kevin/code/bordel/vault-bdeaver-template/vault-token",
					"secret": "database/"
				}
			}
		},
	{{ end -}}
	}
}
