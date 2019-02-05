{{- define "aloha-matrix.name" -}}
{{- if hasSuffix "matrix" .Release.Name -}}
{{- .Release.Name | trunc 63 | lower -}}
{{- else -}}
{{- printf "%s-matrix" .Release.Name | trunc 63 | lower -}}
{{- end -}}
{{- end -}}

{{- define "aloha-matrix.hostname" -}}
{{-  if .Values.tenant.hostnames -}}
{{-    index .Values.tenant.hostnames 0 -}}
{{-  else -}}
{{-    if hasSuffix "matrix" .Release.Name -}}
{{-      printf "%s.%s.%s" .Release.Name .Values.tenant.name .Values.project.domain | trunc 63 | lower -}}
{{-    else -}}
{{-      printf "%s-matrix.%s.%s" .Release.Name .Values.tenant.name .Values.project.domain | trunc 63 | lower -}}
{{-    end -}}
{{-  end -}}
{{- end -}}

{{- define "aloha-matrix.labels" }}
app: aloha-matrix
chart: {{ include "aloha-matrix.chart" . }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
tenant: {{ .Values.tenant.name }}
{{- end }}

{{/* Google Cloud SQL Instance Name: project_id:region:cloudsql_instance */}}
{{- define "aloha-matrix.cloudsqlInstance" -}}
{{- $instance := default (printf "%s-pgdb" .Values.tenant.name) .Values.cloudsql.instance -}}
{{- printf "%s:%s:%s" .Values.project.id .Values.project.region $instance -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "aloha-matrix.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
