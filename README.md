fantastic.quiz
==============
Das FantasticQuiz bietet eine Lernplattform für alle Studierenden.

<h3>Grundfunktionen:</h3>
<ul>
<li>Kategorien anlegen</li>
<li>Fragen anlegen</li>
<li>Kategorien (bzw. Fragen) filtern</li>
<li>Fragen (bzw. Kategorien) den Kategorien (bzw. Fragen) hinzufügen</li>
<li>Eine Kategorie einer anderen Kategorie unterordnen</li>
<li>Für eine Kategorie eine Quizrunde starten</li>
<li>Kategorien mit anderen Benutzern teilen</li>
</ul>

<h3>Testanwendung</h3>
<a href="https://fantasticquiz.herokuapp.com/">https://fantasticquiz.herokuapp.com/</a>

<h3>Details der Anwendung</h3>
<h4>Quizrunden</h4> 
Nach Start einer Quizrunde werden alle Fragen die dieser Kategorie (und der Unterkategorien) zugeordnet sind in zufälliger Reihenfolge abgefragt. Es gibt dabei 3 verschiedenen Varianten:
<ul>
<li>Neue Quizrunde: Alle Fragen werden wieder gestellt</li>
<li>Quizrunde fortsetzen: Ein früher begonnenes Quiz kann fortgesetzt werden</li>
<li>Quizrunde nur mit falschen Antworten (Checking): Es werden nur die Fragen gestellt, die bisher falsch beantwortet wurden</li>
</ul>

<h4>Rechte der Nutzer</h4>
<ul>
<li>Administrator (Rolle admin): Kann alle Kategorien und Fragen sehen</li>
<li>Normale Nutzer: Können ihre eigenen Kategorien und Fragen sehen, sowie für sie freigegebene Kategorien</li>
</ul>

<h4>Kategorien freigeben</h4>
Eine Kategorie kann über die Edit-Ansicht der entsprechenden Kategorie (oder beim Anlegen)  unter "Determine access rights" freigegeben werden.
Die Rechte der Kategorie gehen automatisch auch auf die zugeordneten Fragen über.
Es gibt dabei zwei Möglichkeiten:
<ul>
<li>Voller Zugriff: Die Kategorie kann bearbeitet und um Fragen erweitert werden. Löschen kann jedoch nur der ursprüngliche Ersteller. Aller zugeordneten Fragen können auch anderen Kategorien zugewiesen werden. Außerdem alle Möglichkeiten die durch den lesenden Zugriff gegeben sind.</li>
<li>Lesender Zugriff: Die Kategorie kann angesehen werden und eine Quizrunde zu der Kategorie gestartet werden. Die zugeordneten Fragen können keinen weiteren Kategorien zugewiesen werden.</li>
</ul>

<h4>Fragen löschen</h4>
Möchte man eine Frage löschen und diese ist mehrere Kategorien zugeordnet, muss ausgewählt werden von welcher Kategorie man die Frage löschen möchte und anschließend wird nur diese Verknüpfung, jedoch nicht die Frage an sich gelöscht. Um eine Frage endgültig zu löschen darf sie nur noch einer oder keiner Kategorie zugeordnet sein.

<h4>Standardnutzer</h4>
<ul>
<li>Administrator: admin@admin.de, Passwort: adminadmin</li>
<li>Normaler Nutzer: normal@normal.de, Passwort: normalnormal</li>
</ul>

<h4>Umfang des Standard-Seeds</h4>
Adminstrator und Normaler Nutzer wie oben angegeben. 5 Kategorien und 7 Fragen von denen der Administrator der Besitzer ist. Der Normale Nutzer hat weder Kategorien noch Fragen.

<h3>Details zur Entwicklung</h3> 
<h4>User-Stories:</h4> 
Das Projekt umfasst 30 Userstories die in einer LibreOffice Datei festgehalten sind. Die Datei heißt UserStories.odp und liegt neben dieser Readme-Datei in GitHub.

<h4>Testumfang:</h4> 
<b>Starte rspec-Tests über:<i>   bundle exec rspec</i></b><br>
<b>Beschreibung der Testfälle: </b>
<ul>
<b><i>spec/features/questions_spec</i></b>
<li>Erstellen, Löschen, Ändern und Anzeigen von Fragen</li>
<b><i>spec/features/categories_spec</i></b>
<li>Erstellen, Löschen, Ändern und Anzeigen von Kategorien</li>
<b><i>spec/features/quiz_round_spec</i></b>
<li>Starten und Ausführen einer Quizrunde</li>
</ul>

<h4>Genutzte Gems:</h4>
<ul>
<li>devise</li>
<li>devise-bootstrap-views</li>
<li>twitter-bootstrap-rails</li>
<li>rolify</li>
<li>ransack</li>
<li>font-awesome-rails</li>
<li>capybara</li>
</ul>

<h4>Projektteilnehmer:</h4>
<ul>
<li>Roman Busch</li>
<li>Thomas Sennekamp</li>
<li>Theresa Sollert</li>
<li>Jos Werner</li>
</ul>
