import List "mo:base/List";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";

actor DKeeper {

  public type Note = {
    title: Text;
    content: Text;
  };

  stable var notes: List.List<Note> = List.nil<Note>();

  public func createNote(titleText: Text, contentText: Text) {

    let newNote: Note = {
      title = titleText;
      content = contentText;
    };

    notes := List.push(newNote, notes);
    Debug.print(debug_show(notes));
  };

  public query func readNotes(): async [Note] {
    return List.toArray(notes);
  };

  public func removeNote(id: Nat) {
    var currentId = 0;

    notes := List.filter<Note>(notes, func x { 
      if(id == currentId) {
        return false;
      } else {
        currentId += 1;
        return true;
      }
    });

    Debug.print(debug_show(notes));
  };

  public func deleteNote(id: Nat) {
    let topHalf = List.take(notes, id);
    let bottomHalf = List.drop(notes, id + 1);
    notes := List.append(topHalf, bottomHalf);

    Debug.print(debug_show(notes));
  }
}