# Proyecto de Limpieza de Datos de Reservas (MySQL)
Este proyecto se centra en demostrar la importancia fundamental de la limpieza de datos (Data Cleaning) como la fase crítica donde se conoce realmente el dataset y se identifican sus problemas de calidad. El objetivo principal fue auditar, estandarizar y transformar un conjunto de datos de reservas de viajes (trips) para garantizar su fiabilidad y prepararlo para cualquier análisis o modelo futuro.

# Contexto y Análisis Detallado
La metodología aplicada y el proceso de pensamiento detrás de cada decisión de limpieza —especialmente cómo se descubrieron y mitigaron los problemas de calidad de la fuente— están documentados en detalle en mi artículo de Medium:

    https://medium.com/@mateov55/de-estudiante-a-analista-aprendiendo-data-cleaning-con-sql-40e56c6e3d83

# Herramientas utilizadas

Herramientas Utilizadas

  Motor de Base de Datos: MySQL

  Lenguaje de Consulta: SQL

  Herramientas Auxiliares: (Ej. MySQL Workbench, CSV file)

# Metodología
Se evidencia el data original (data_raw) en un formato csv que subí a la base de datos de MySQL Workbench para su limpieza:

<img width="1340" height="262" alt="1_yoxHiyuXAzEksODhWbpc1w" src="https://github.com/user-attachments/assets/54d5b139-986e-4327-9ffd-a2e1ad9ab833" />
<img width="351" height="267" alt="1_P_XesDyojhAJNzvAb369vQ" src="https://github.com/user-attachments/assets/f969820f-a315-47d9-b188-27fff5da487f" />



Copia de Seguridad y Trazabilidad: Se creó la tabla trips_staging a partir de la fuente para trabajar de manera segura.

Identificador Único: Se añadió un id con auto-incremento, esencial para gestionar la granularidad del dato antes de la eliminación de duplicados.

Descubrimiento de Duplicados: Se identificaron y eliminaron duplicados exactos basados en campos clave (booking_id, email, checkin_date, checkout_date), un paso crucial para asegurar que las métricas posteriores no estuvieran infladas.

# Script SQL

El código completo y comentado que implementa esta metodología se encuentra en el archivo:

    data_cleaning.sql


