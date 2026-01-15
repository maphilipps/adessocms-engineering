<anti_patterns_overview>
Zusammenfassung aller Design-Fehler die gegen den adesso Styleguide verstoßen. Diese Liste dient als schnelle Referenz beim Review.
</anti_patterns_overview>

<color_violations>

<violation severity="critical" name="adesso-Blau Tints">
**Problem:** Verwendung von helleren/dunkleren Varianten von adesso-Blau
**Beispiel:** `#3389d2`, `#0055a0`, `bg-blue-400`
**Warum verboten:** adesso-Blau hat KEINE erlaubten Abstufungen
**Lösung:** Nur #006ec7 verwenden. Bei Kontrast-Problemen: Weiß oder adesso-Grau
</violation>

<violation severity="critical" name="Herbstfarben">
**Problem:** Warme Braun-/Rottöne
**Beispiel:** `#8B4513`, `#A0522D`, Sienna, Tan, Maroon
**Warum verboten:** Widerspricht der kühlen, modernen adesso-Palette
**Lösung:** adesso-Grau oder Akzentfarben verwenden
</violation>

<violation severity="high" name="Gradienten ohne Blau">
**Problem:** Farbverläufe die kein adesso-Blau enthalten
**Beispiel:** `linear-gradient(#ff9868, #f566ba)`
**Warum verboten:** Alle Gradienten MÜSSEN adesso-Blau enthalten
**Lösung:** adesso-Blau als Start-, End- oder Mittelpunkt hinzufügen
</violation>

<violation severity="medium" name="Zu viele Akzentfarben">
**Problem:** Mehr als 2 Akzentfarben gleichzeitig dominant
**Beispiel:** Gelb + Pink + Grün + Orange in einem Design
**Warum verboten:** Überlädt das Design, verwässert Brand
**Lösung:** Maximal 2 Akzentfarben pro Design/Section
</violation>

<violation severity="low" name="Standard-Tailwind-Farben">
**Problem:** Verwendung von blue-500, gray-200, etc.
**Beispiel:** `text-blue-500` statt `text-adesso-blau`
**Warum verboten:** Nicht Brand-konform
**Lösung:** Nur adesso-Farbklassen verwenden
</violation>

</color_violations>

<typography_violations>

<violation severity="high" name="Klavika für Fließtext">
**Problem:** Klavika für Body-Text oder längere Passagen
**Beispiel:** `<p class="font-headline">Langer Absatz...</p>`
**Warum verboten:** Klavika ist eine Headline-Schrift
**Lösung:** ABC Marist oder Fira Sans für Body
</violation>

<violation severity="high" name="Fremde Schriften">
**Problem:** Verwendung nicht-adesso Schriften
**Beispiel:** Arial, Helvetica, Roboto, Inter
**Warum verboten:** Nicht Teil des adesso Design Systems
**Lösung:** Klavika, ABC Marist oder Fira Sans
</violation>

<violation severity="medium" name="Zu kleiner Body-Text">
**Problem:** Body-Text unter 16px
**Beispiel:** `text-xs` für Haupttext
**Warum verboten:** Schlechte Lesbarkeit
**Lösung:** Minimum 16px (text-base) für Body
</violation>

<violation severity="medium" name="ALL CAPS Headlines">
**Problem:** Lange Headlines komplett in Großbuchstaben
**Beispiel:** `<h1 class="uppercase">DIES IST EINE SEHR LANGE HEADLINE</h1>`
**Warum verboten:** Schlechte Lesbarkeit bei langen Texten
**Lösung:** Normal-Case oder Title-Case
</violation>

</typography_violations>

<icon_violations>

<violation severity="critical" name="Falsche Icon-Styles">
**Problem:** FontAwesome Icons nicht im Thin-Style
**Beispiel:** `fa-solid`, `fa-regular`, `fa-light`, `fa-duotone`
**Warum verboten:** Nur fa-thin ist erlaubt
**Lösung:** Alle Icons auf `fa-thin` umstellen
</violation>

<violation severity="high" name="Andere Icon-Sets">
**Problem:** Material Icons, Heroicons, Feather, etc.
**Beispiel:** `<span class="material-icons">home</span>`
**Warum verboten:** Nur FontAwesome Thin erlaubt
**Lösung:** FontAwesome Thin Äquivalent finden
</violation>

<violation severity="medium" name="Zu kleine Icons">
**Problem:** Icons unter 14px
**Beispiel:** FontAwesome Thin unter fa-sm
**Warum verboten:** Thin-Linien werden unsichtbar
**Lösung:** Minimum 14px (fa-sm)
</violation>

</icon_violations>

<logo_violations>

<violation severity="critical" name="Logo-Farbe geändert">
**Problem:** Logo in anderen Farben als Blau/Weiß/Schwarz
**Beispiel:** Grünes Logo, graues Logo, Regenbogen-Logo
**Warum verboten:** Logo hat nur 3 erlaubte Farbvarianten
**Lösung:** adesso-logo-blue.svg, -white.svg oder -black.svg
</violation>

<violation severity="critical" name="Logo verzerrt">
**Problem:** Logo gestreckt, gestaucht, rotiert
**Beispiel:** `transform: scaleX(1.5)` auf Logo
**Warum verboten:** Verzerrt die Marke
**Lösung:** Seitenverhältnis beibehalten
</violation>

<violation severity="high" name="Schutzzone verletzt">
**Problem:** Elemente zu nah am Logo
**Beispiel:** Text direkt neben Logo ohne Abstand
**Warum verboten:** Schutzzone = Höhe des "d"
**Lösung:** Mindestabstand einhalten
</violation>

<violation severity="high" name="Logo mit Effekten">
**Problem:** Schatten, Glow, Outline auf Logo
**Beispiel:** `box-shadow: 0 0 10px #006ec7`
**Warum verboten:** Logo muss pur bleiben
**Lösung:** Alle Effekte entfernen
</violation>

<violation severity="medium" name="Logo zu klein">
**Problem:** Logo unter Mindestgröße
**Beispiel:** Logo kleiner als 100px (digital) oder 25mm (print)
**Warum verboten:** Nicht mehr lesbar
**Lösung:** Mindestgröße einhalten oder weglassen
</violation>

</logo_violations>

<general_violations>

<violation severity="high" name="Holografische Effekte">
**Problem:** Regenbogen-/Holografie-Effekte
**Beispiel:** `background: linear-gradient(...rainbow colors...)`
**Warum verboten:** Explizit im Styleguide ausgeschlossen
**Lösung:** adesso-Gradienten verwenden
</violation>

<violation severity="high" name="Roboter-/KI-Bildwelt">
**Problem:** Generische Roboter-Bilder, typische "KI"-Visualisierungen
**Beispiel:** Stock-Roboter, blaue Gehirn-Grafiken
**Warum verboten:** Explizit im Styleguide ausgeschlossen
**Lösung:** Authentische Bilder, Menschen, abstrakte Grafiken
</violation>

<violation severity="medium" name="Unruhige Hintergründe">
**Problem:** Busy patterns, komplexe Texturen hinter Content
**Beispiel:** Gepunktete Muster, kleine wiederholende Grafiken
**Warum verboten:** Stört Lesbarkeit und wirkt billig
**Lösung:** Einfarbige Flächen, dezente Gradienten
</violation>

<violation severity="low" name="Inkonsistente Rundungen">
**Problem:** Verschiedene border-radius Werte
**Beispiel:** `rounded-sm`, `rounded-lg`, `rounded-xl` gemischt
**Warum verboten:** Uneinheitliches Erscheinungsbild
**Lösung:** Konsistent `rounded-adesso` (8px) verwenden
</violation>

</general_violations>

<quick_check_list>
**Schnell-Check vor Review:**

**Farben:**
- [ ] Kein adesso-Blau Tint (#006ec7 ist heilig)
- [ ] Keine Herbstfarben (Braun, Rot)
- [ ] Gradienten haben adesso-Blau
- [ ] Max 2 Akzentfarben

**Typografie:**
- [ ] Klavika nur für Headlines
- [ ] Body-Text min 16px
- [ ] Nur Klavika/ABC Marist/Fira Sans

**Icons:**
- [ ] NUR fa-thin
- [ ] Min 14px Größe
- [ ] Keine anderen Icon-Sets

**Logo:**
- [ ] Nur Blau/Weiß/Schwarz
- [ ] Nicht verzerrt
- [ ] Schutzzone eingehalten
- [ ] Keine Effekte

**Allgemein:**
- [ ] Keine Holografie-Effekte
- [ ] Keine Roboter-Bilder
- [ ] Ruhige Hintergründe
</quick_check_list>
