{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "fluentd.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fluentd.fullname" -}}
{{- $name := default "fluentd" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a fully qualified server name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fluentd.aggregator.fullname" -}}
{{- printf "%s-%s" .Release.Name "fluentd-aggregator" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "aws.credentials.env" }}
- name: AWS_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ template "fluentd.fullname" . }}-secrets
      key: aws-access-key
- name: AWS_SECRET_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ template "fluentd.fullname" . }}-secrets
      key: aws-secret-key
- name: AWS_REGION
  valueFrom:
    secretKeyRef:
      name: {{ template "fluentd.fullname" . }}-secrets
      key: aws-region
{{- end -}}
