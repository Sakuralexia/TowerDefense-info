# Relazione sul Progetto di Gioco Tower Defense in Processing

## Introduzione
Il progetto consiste nello sviluppo di un gioco Tower Defense utilizzando il linguaggio Processing. Il progetto è organizzato in diverse classi che gestiscono: nemici, torri, proiettili e la logica generale del gioco. L**UML descrive l**architettura del gioco, evidenziando le interazioni tra le principali entità.

---

## Struttura del Gioco
Il gioco si basa su diverse classi, ognuna con un ruolo specifico:

### Classe **Game**
La classe principale del gioco gestisce gli elementi chiave come nemici, torri e proiettili. Mantiene lo stato del gioco, incluso il punteggio, le vite rimanenti e la gestione delle ondate di nemici.

**Metodi principali:**
- **startNewWave()**: avvia una nuova ondata di nemici.
- **spawnEnemy()**: genera nemici.
- **update()**: aggiorna lo stato del gioco.
- **victory()** e **gameOver()**: determinano la fine o la vittoria della partita.
- **placeTower()**: permette di posizionare una torre sulla griglia.

### Classe **Enemy** e Sottoclassi
La classe **Enemy** rappresenta un nemico e include attributi come posizione, punti vita e stato.

**Metodi principali:**
- **move()**: gestisce il movimento del nemico lungo il percorso.
- **takeDamage()**: riduce la vita del nemico quando colpito.
- **display()**: visualizza il nemico a schermo.

Le sottoclassi **FastEnemy**, **SlowEnemy** e **BossEnemy** specializzano il comportamento dei nemici, differenziandosi per velocità e vita.

### Classe **Tower**
Le torri rappresentano le unità difensive del giocatore. Gli attributi principali includono posizione, velocità di fuoco, ultimo colpo sparato e raggio d**azione.

**Metodi principali:**
- **shoot()**: permette alla torre di attaccare un nemico.
- **display()**: gestisce la visualizzazione della torre.

### Classe **Bullet**
I proiettili sparati dalle torri sono rappresentati dalla classe **Bullet**, che contiene informazioni sulla velocità, il bersaglio e lo stato dell**impatto.

**Metodi principali:**
- **move()**: aggiorna la posizione del proiettile.
- **display()**: gestisce la sua rappresentazione grafica.

### Classi di Gestione
- **GridManager**: gestisce la griglia su cui si muovono i nemici e vengono posizionate le torri.
- **PositionManager**: controlla la validità delle posizioni sulla griglia per torri e nemici.
- **ErrorManager**: gestisce i messaggi di errore per il giocatore.

### Classe **main**
La classe principale del programma inizializza il gioco e gestisce l’input dell’utente. Comprende metodi per il setup, il rendering e la gestione del mouse.

---

## Problematiche nel Processo di Sviluppo
All’inizio il progetto procedeva senza problemi, ma una volta affrontate le parti più complesse ho dovuto modificare il codice molte volte per testare i cambiamenti in tempo reale. Dopo vari tentativi, il gioco è diventato più fluido, anche se non del tutto ottimizzato. Quando sono riuscita a sistemare le classi principali e mi sono concentrata sull’estensione del codice per creare nuovi nemici e bilanciare il gameplay con piccoli dettagli, il lavoro è diventato più gestibile e lineare.

---

### **Requisiti Funzionali**  
- Il gioco deve permettere di posizionare torri sulla griglia.  
- I nemici devono seguire un percorso predefinito.  
- Le torri devono attaccare automaticamente i nemici nel loro raggio d’azione.  
- I proiettili devono colpire e infliggere danno ai nemici.  
- Il gioco deve gestire più ondate di nemici con difficoltà crescente.  
- Deve esserci una condizione di vittoria e sconfitta.  

### **Requisiti Non Funzionali**  
- Il gioco deve essere fluido e responsivo.  
- Il codice deve essere organizzato in classi per una facile estensibilità.  
- L’interfaccia deve essere intuitiva e leggibile.  
- Il sistema deve fornire feedback visivi per azioni come attacchi e danni.  
- Deve essere compatibile con Processing.  
![uml drawio](https://github.com/user-attachments/assets/dfd7dfeb-d3db-4c4e-9c49-9c02dc484ebf)

