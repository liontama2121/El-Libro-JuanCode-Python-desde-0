/* ==========================================================================
   ⚙️ CONFIGURACIÓN — el ÚNICO archivo que hay que tocar
   ==========================================================================

   Cambiar el número de WhatsApp o el calendario es cambiar UNA línea aquí.
   Todos los botones (contacto, flotante, fallback de la agenda), el iframe de
   reservas y los links a redes leen de este objeto.

   · WHATSAPP_URL   → https://wa.me/57 + tu celular sin espacios ni signos
                       ejemplo: https://wa.me/573001234567
   · LIBRO_URL      → donde vive El Libro JuanCode. Hoy es la URL de
                       Cloudflare Workers; el día que registres juancode.co,
                       cámbiala por https://libro.juancode.co.
                       Abriendo la landing en localhost se usa LIBRO_URL_LOCAL.
   · TIKTOK_URL / INSTAGRAM_URL → tus perfiles

   Mientras WHATSAPP_URL siga con el valor de ejemplo (XXXXXXXXXX) la página
   lo avisa en la consola del navegador.
   ========================================================================== */

window.JUANCODE = {
	WHATSAPP_URL: "https://wa.me/573046452629",
	LIBRO_URL: "https://libro-juancode.juankmolina2121.workers.dev",
	// Solo se usa cuando abres esta landing en tu propio computador,
	// para poder probar el botón contra el libro corriendo en local.
	LIBRO_URL_LOCAL: "http://localhost:5173",
	TIKTOK_URL: "https://www.tiktok.com/@juancode",
	INSTAGRAM_URL: "https://www.instagram.com/juancode",
};
