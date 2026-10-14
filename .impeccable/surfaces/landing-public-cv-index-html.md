---
version: 1
slug: "landing-public-cv-index-html"
primary_target: "landing/public/cv/index.html"
related_targets: ["landing/public/web/index.html","landing/public/index.html"]
---

## Scope

Página nueva `/cv` (landing/public/cv/index.html): hoja de vida de Juan Camilo Molina León en formato blog-crónica. Modo: Experience (reclutadores, líderes técnicos y clientes de IA leen la trayectoria). Hereda el mundo Visor HUD sin cambios de sistema.

Audiencia: reclutadores y líderes de arquitectura/IA del sector financiero; clientes que quieren asistentes con IA. Acción: descargar el PDF, escribir al correo o abrir LinkedIn. Contacto público: correo + LinkedIn + PDF, sin teléfono. Enlazada desde el nav de /web y la portada.

Fuente única de hechos: CV_Juan_Camilo_Molina_Leon.pdf (no inventar métricas ni empresas).

## Direction contract

THESIS: La hoja de vida se lee como una crónica publicada en el visor, no como un PDF en HTML ni un grid de tarjetas: cada empleo es un capítulo con su prueba concreta, y la escena demuestra el oficio actual (agentes RAG con supervisor).

OWN-WORLD: Visor HUD intacto: negro #05070b, retícula y barrido, cian para acción, magenta como segundo neón (IA/agentes), radio 0, esquinas de mira, Archivo ancho 112 en titulares, JetBrains Mono en cifras, fechas y etiquetas.

STORY: El visitante entiende en un vistazo que Juan diseña IA agéntica para banca, lee capítulos BBVA, Cobis Topaz, JuanCode y trayectoria previa, ve el arsenal de habilidades agrupado y descarga el CV o escribe.

FIRST VIEWPORT: Izquierda: nombre grande, rol con "IA generativa y agéntica" en neón, una línea de perfil, CTAs Descargar CV (cian) y LinkedIn (línea). Derecha: escena canvas "agentes": pregunta entra, supervisor reparte a agentes, retrieval a OpenSearch, respuesta sale; placa con esquinas de mira.

FORM: Blog-crónica, posición 7 de la lista ordenada (repartida por los dados y elegida por el usuario), seed key dcc13708. Interacción firma: escena de agentes en canvas + ficha lateral fija con índice de capítulos que marca la sección activa.

FINISH: unreviewed and undocumented is unfinished; this build ends with the finish review, the verdict, DESIGN.md, and every shipping raster carrying its provenance
