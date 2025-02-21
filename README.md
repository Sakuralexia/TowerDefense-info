Relazione sul Progetto di Gioco Tower Defense in Processing
Introduzione
Il progetto consiste nello sviluppo di un gioco Tower Defense utilizzando il linguaggio Processing. Il progetto è organizzato in diverse classi che gestiscono: nemici, torri, proiettili e la logica generale del gioco. L'UML descrive l'architettura del gioco, evidenziando le interazioni tra le principali entità.
Struttura del Gioco
Il gioco si basa su diverse classi, ognuna con un ruolo specifico:
Classe Game
La classe principale del gioco gestisce gli elementi chiave come nemici, torri e proiettili. Mantiene lo stato del gioco, incluso il punteggio, le vite rimanenti e la gestione delle ondate di nemici. Le sue funzioni principali sono:
•	startNewWave(): avvia una nuova ondata di nemici.
•	spawnEnemy(): genera nemici.
•	update(): aggiorna lo stato del gioco.
•	victory() e gameOver(): determinano la fine o la vittoria della partita.
•	placeTower(): permette di posizionare una torre sulla griglia.
Classe Enemy e Sottoclassi
La classe Enemy rappresenta un nemico e include attributi come posizione, punti vita e stato. I metodi principali sono:
•	move(): gestisce il movimento del nemico lungo il percorso.
•	takeDamage(): riduce la vita del nemico quando colpito.
•	display(): visualizza il nemico a schermo.
Le sottoclassi FastEnemy, SlowEnemy e BossEnemy specializzano il comportamento dei nemici, differenziandosi per velocità e vita.
Classe Tower
Le torri rappresentano le unità difensive del giocatore. Gli attributi principali includono posizione, velocità di fuoco, ultimo colpo sparato e raggio d'azione. Le funzioni principali sono:
•	shoot(): permette alla torre di attaccare un nemico.
•	display(): gestisce la visualizzazione della torre.
Classe Bullet
I proiettili sparati dalle torri sono rappresentati dalla classe Bullet, che contiene informazioni sulla velocità, il bersaglio e lo stato dell'impatto. I metodi principali sono:
•	move(): aggiorna la posizione del proiettile.
•	display(): gestisce la sua rappresentazione grafica.
Classi di Gestione
•	GridManager: gestisce la griglia su cui si muovono i nemici e vengono posizionate le torri.
•	PositionManager: controlla la validità delle posizioni sulla griglia per torri e nemici.
•	ErrorManager: gestisce i messaggi di errore per il giocatore.
Classe main
La classe principale del programma inizializza il gioco e gestisce l'input dell'utente. Comprende metodi per il setup, il rendering e la gestione del mouse.
Problematiche nel processo di svolgimento:
All’inizio andava tutto liscio, ma dopo appena veniva la parte più complicata ho modificato il codice molte volte per vedere i cambiamenti in diretta. Dopo un po’ è andato poco più fluido ma non troppo. Quando sono riuscita a sistemare le classi principale e dovevo solo estendere per creare nuovi nemici e/o equilibrare il gioco aggiungendo piccoli dettagli, era molto più tranquillo e liscio.  

