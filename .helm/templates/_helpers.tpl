{{- define "apps-backend.branch" }}
{{- .Values.branch | replace "0" "a" | replace "1" "b" | replace "2" "c" | replace "3" "d" | replace "4" "e" | replace "5" "f" | replace "6" "g" | replace "7" "h" | replace "8" "i" | replace "9" "j" | replace " " "-" | replace "_" "-" | kebabcase }}
{{- end }}

{{- define "apps-backend.namespace" }}
{{- if eq .Values.branch "master" }}{{ .Values.namespace }}-production{{ else }}{{ .Values.namespace }}{{ end }}
{{- end }}
