        {{/*
        Expand the name of the chart.
        */}}
        {{- define "taskflow-app.name" -}}
        {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
        {{- end -}}

        {{/*
        Create a default fully qualified app name.
        We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
        If release name contains chart name it will be used as a full name.
        */}}
        {{- define "taskflow-app.fullname" -}}
        {{- if .Values.fullnameOverride -}}
        {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
        {{- else -}}
        {{- $name := default .Chart.Name .Values.nameOverride -}}
        {{- if contains $name .Release.Name -}}
        {{- .Release.Name | trunc 63 | trimSuffix "-" -}}
        {{- else -}}
        {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
        {{- end -}}
        {{- end -}}
        {{- end -}}

        {{/*
        Create chart name and version as part of the labels
        */}}
        {{- define "taskflow-app.labels" -}}
        helm.sh/chart: {{ include "taskflow-app.chart" . }}
        {{ include "taskflow-app.selectorLabels" . }}
        {{- if .Chart.AppVersion }}
        app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
        {{- end }}
        app.kubernetes.io/managed-by: {{ .Release.Service }}
        {{- end -}}

        {{/*
        Selector labels
        */}}
        {{- define "taskflow-app.selectorLabels" -}}
        app.kubernetes.io/name: {{ include "taskflow-app.name" . }}
        app.kubernetes.io/instance: {{ .Release.Name }}
        {{- end -}}

        {{/*
        Create the name of the chart.
        */}}
        {{- define "taskflow-app.chart" -}}
        {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
        {{- end -}}
        