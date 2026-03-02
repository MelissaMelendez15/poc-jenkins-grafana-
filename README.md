# Observabilidad en CI – Prueba de Concepto (PoC)

## 🎯 Objetivo

Demostrar cómo instrumentar un pipeline de Jenkins con métricas personalizadas
utilizando Pushgateway, Prometheus y Grafana.

Esta PoC valida el flujo completo de observabilidad aplicado a procesos CI.

---

## 🏗 Arquitectura

![Arquitectura CI Observability](/docs/architecture.png)

---

## 🔄 Flujo de funcionamiento

1. Jenkins ejecuta el pipeline.
2. Un script Bash (`push_metrics.sh`) genera métricas en formato Prometheus.
3. Las métricas se envían vía HTTP a Pushgateway (modelo push).
4. Prometheus scrapea Pushgateway (modelo pull).
5. Grafana consulta Prometheus mediante PromQL y visualiza los resultados.

---

## 📊 Métricas actuales (modo demo)

Actualmente se envían métricas sintéticas para validar el flujo técnico:

- `poc_input_value`
- `poc_input_avg`
- `poc_input_max`
- `poc_input_ok`

Estas métricas no representan aún datos reales del pipeline, sino que permiten comprobar correctamente la integración entre los componentes.

---

## 🧠 Conceptos técnicos clave

- Diferencia entre modelo push y pull en Prometheus
- Uso de Pushgateway para procesos de corta duración (batch jobs como CI)
- Transformación automática de etiquetas (`job` → `exported_job`)
- Modelado básico de métricas
- Base para aplicar principios SRE a pipelines CI

---

## 🚀 Evolución prevista

La siguiente fase consistirá en instrumentar métricas reales del pipeline, tales como:

- Duración total del pipeline
- Tasa de fallos
- Ratio de éxito
- Métricas por stage
- Análisis de percentiles (p95)

El objetivo es convertir esta PoC en un módulo de Observabilidad de Rendimiento en CI con enfoque SRE.
