Code Review by Aynel Gül 
____________________________________

- Netjes dat de controllers/models/storyboards in aparte groups zitten, overzichtelijk.
- Mooie overzichtelijke layout met duidelijke namen (login/book/chores).
- Misschien wel wat meer korte/concrete comments toevoegen zodat je code wat beter leesbaar is (in BookViewController).
- Probeer om in de ViewDidLoad voornamelijk functies te gebruiken.
- Evetueel je '//MARK's consistenter maken over de viewcontrollers: ongeveer zelfde MARK's als dat kan, met dezelfde namen.
- Eventueel een error/alert als HTTP request niet lukt door geen internetverbinding.
- Help text misschien iets naar beneden verplaatsen: overlapt met bovenkant scherm.
- State restoration werkt nog niet helemaal als je van 'help' terug gaat naar het inlogscherm.
- Wel beetje onduidelijk dat 'Book' en '+' naast elkaar staan in de navigation controller: niet helemaal duidelijk wat de '+' dan doet; boek toevoegen of chores toevoegen.
- Mooi dat ie done/not done op volgorde zet!
- Heel vet dat je naar de online versie kan van het boek! Werkt goed.
- Ik zou 'save' en 'cancel' andersom doen bij alert voor toevoegen chores: intuitiever.
- Als je uitlogt blijft het wachtwoord staan: eventueel op leeg zetten textfield.text = ""

