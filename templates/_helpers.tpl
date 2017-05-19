{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "fluentd.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "collector.fullname" -}}
{{- $name := default "collector" .Values.collector.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "aggregator.fullname" -}}
{{- $name := default "aggregator" .Values.aggregator.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
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
