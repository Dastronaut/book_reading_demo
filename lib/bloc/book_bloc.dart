import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/book.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial()) {
    on<LoadBook>(_onLoadBook);
    on<UnlockChapter>(_onUnlockChapter);
  }

  void _onLoadBook(LoadBook event, Emitter<BookState> emit) async {
    emit(BookLoading());
    try {
      // Create initial book with chapters
      final book = Book(
        title: 'The Last Ember',
        chapters: [
          Chapter(
            id: 1,
            title: 'Chapter 1: The Last Ember',
            pages: [
              const Page(
                number: 1,
                content:
                    '''Rain soaked the cracked windows of the old cottage where Elira sat alone, her fingers curled tightly around the faded letter she had read a hundred times. The fire in the hearth had long gone cold, reduced to a pile of gray ash that gave no heat, only memories. Every creak of the wooden beams overhead sounded like a cry from the past. She had lived here with Kalen for as long as she could remember—through wars, through winters, through grief. And now, she was alone.
The storm outside grew fiercer, as if mourning with her. Wind howled through the cracks, stirring the dying embers in the hearth. The scent of rain and charred oak filled the air—a bitter perfume that only deepened her ache. The world outside moved on, but her world had paused in stillness. In mourning. In defiance.
She pressed the letter to her chest, eyes shut tightly. Kalen missing? Presumed dead? No. She would not accept it. Not when she could still feel him in every corner of this house. Not when their bond had never failed her.''',
              ),
              const Page(
                number: 2,
                content:
                    '''The letter had come from the front lines—delivered by a trembling courier who couldn't meet her eyes. It bore the seal of the Crown and the sharp, clinical tone of a military report. "Presumed lost in action." Three words to erase a life. A laugh. A brother. But Elira wasn't a woman who accepted the easy death of hope.
Memories rushed her. Kalen's voice calling to her in the snow. His hand shielding her during the fires. The way he used to say, "If I die, you'll know. You'll feel the silence." But there was no silence now—only noise. Noise that screamed he was still out there.
The letter slipped from her grasp, landing on the wooden floor with a quiet rustle. She stared at it, then rose slowly, a resolve settling in her bones like steel. If no one would search, she would. If no one believed, she would carry the belief for them all.''',
              ),
              const Page(
                number: 3,
                content:
                    '''She stepped out into the storm, boots crunching against wet leaves and broken roots. The village square lay behind her, shuttered windows and silent doors watching her like wary ghosts. An old woman leaned from a window and whispered, "Let the dead be."
Elira paused. Then, without turning, she whispered back, "He's not dead." Her voice didn't waver.
Every raindrop felt like a warning. Every gust of wind tugged at her cloak as though begging her to turn back. But she would not. Not now. Not ever. Her brother was out there in the dark, and she would walk into it without fear.
As she disappeared into the trees, the village lights blinked behind her like stars fading into the dawn. Let them whisper. Let them doubt. She walked for blood. For truth. For family. And whatever waited in the woods ahead, it would not find her easy to break.''',
              ),
            ],
            isUnlocked: true,
            unlockCost: 0,
          ),
          Chapter(
            id: 2,
            title: 'Chapter 2: Hollow Paths',
            pages: [
              const Page(
                number: 1,
                content:
                    '''The forest stood before her like a cathedral of shadows—its tall pines clawing at the sky, its canopy swallowing the last light of the sun. Every step Elira took deeper into it felt like a journey back through time, through layers of forgotten sorrow and secrets never meant to be unearthed.
The air grew colder, thicker. Birds no longer sang. Only the steady drum of her boots against damp earth and the brittle crackle of old leaves dared make a sound. The deeper she went, the more the forest seemed to lean in—branches arching above her like silent judges.
She passed stone markers choked with ivy, worn symbols etched by hands long dead. A story was buried here. Not one written in parchment, but in bones and whispers. And Elira, heart steady, dared to read it. The air began to hum with unease. She didn't care. Whatever nightmare this place held, it was no worse than the silence of giving up.''',
              ),
              const Page(
                number: 2,
                content:
                    '''She saw it first out of the corner of her eye—a flicker, a distortion in the air. A shadow moving without a source. Not a beast. Not a man. Something ancient. Something watching.
Her breath caught. Not out of fear, but recognition. As if the thing had always lived on the edge of her dreams. It didn't move toward her. It didn't flee. It simply stood there, just beyond her sight, daring her to acknowledge it.
And then the whisper came. Not from the trees. Not from the wind. But from inside her skull. A single word: "Return." Her body stiffened, but she did not falter. She spoke back, her voice raw: "I never left." The forest shuddered.
Elira pushed on. Fear had no place in her heart—not anymore. What mattered was ahead, buried beneath the weight of time and legend. She would tear it out with her bare hands if she had to.''',
              ),
              const Page(
                number: 3,
                content:
                    '''The clearing came suddenly, like a wound in the forest's flesh. Burned wagons and shattered weapons lay half-sunk in mud and moss. Torn banners fluttered weakly in the breeze. The remnants of a battle—but no bodies.
Elira knelt by a scorched shield, her fingers tracing the crest. This was Kalen's unit. There was no mistaking it. The symbol etched into the charred wood burned itself into her memory: a black crown, broken in two. A symbol older than the kingdom itself.
Something terrible had happened here. Not a fight. A massacre. A ritual. Something meant to erase.
In the center of the clearing, where nothing dared grow, a symbol had been seared into the ground. It pulsed faintly. She didn't understand its meaning—but her bones did. It was the mark of a king long forgotten… and perhaps something worse.''',
              ),
            ],
            isUnlocked: false,
            unlockCost: 50,
          ),
          Chapter(
            id: 3,
            title: 'Chapter 3: A Flame Rekindled',
            pages: [
              const Page(
                number: 1,
                content:
                    '''Elira barely slept. When she did, dreams came like knives—visions of fire, screams in the dark, and a single word repeated over and over in Kalen's voice: "Run." But she didn't run. She waited. And in the quiet between nightmares, something moved.
A figure stumbled from the trees, cloaked in dirt and blood. He fell to his knees just beyond the fire she had built. His face was half-hidden by filth and tangled hair, but she knew him. Even in ruin. Even in horror.
"Kalen."
He looked up, eyes hollow and too wide, like someone who had looked too long into the abyss. For a moment, there was no recognition. Then, faintly, a whisper: "Elira?"
She ran to him. Held him like a lifeline. But he didn't return the embrace. His hands hung limp. His soul was here, but not whole.''',
              ),
              const Page(
                number: 2,
                content:
                    '''They sat in silence, save for the snapping of firewood. Kalen's skin was cold, his voice colder. "They took them," he said. "They whispered… inside our heads. Said we'd serve a purpose. Said the mountain was waiting."
Elira listened, heart breaking. This wasn't the brother who had once stood taller than fear. This was a man broken in places she couldn't yet see. His voice shook when he spoke of the others—how they vanished one by one, how he alone survived. Or was left behind.
"They want something," he murmured. "Not just flesh. Memory. Names. Blood."
Elira didn't flinch. She reached for his hand again. This time, he didn't pull away. It was small. But it was something.
The road ahead was darker than she imagined. But now she had something stronger than vengeance. She had someone to protect.''',
              ),
              const Page(
                number: 3,
                content:
                    '''That night, Kalen screamed in his sleep—raw, wounded howls that tore through the forest like a wounded animal. Elira held him down, whispering his name again and again until his body stilled.
She didn't sleep after that. She sharpened her sword. She studied the map they had drawn together as children. And she whispered an oath to the flames: "I will burn heaven, hell, and all between if that's what it takes."
When dawn broke, she was ready. Kalen, pale and shaking, stood beside her. There was fear in his eyes. But also something else. A flicker. A spark.
The mountain waited. And now they would go to it—not as mourners, but as avengers.''',
              ),
            ],
            isUnlocked: false,
            unlockCost: 100,
          ),
          Chapter(
            id: 4,
            title: 'Chapter 4: Beneath Black Stone',
            pages: [
              const Page(
                number: 1,
                content:
                    '''The mountain rose like a wound on the earth's back—black, jagged, ancient. Its peak disappeared into storm clouds that didn't move. At its base, the air was heavy, every breath like swallowing smoke.
The entrance was not hidden. It waited for them—wide, gaping, lined with obsidian teeth. As they stepped inside, the temperature dropped instantly. Light seemed afraid to follow them in.
Inside, the walls whispered. Not words. Sounds. Echoes of screams from centuries past. Symbols danced across the stone in flickers of red and gold. The torches Elira lit sputtered but held.
The mountain was alive. Not with wind or beast—but memory. And it hated them.''',
              ),
              const Page(
                number: 2,
                content:
                    '''The descent was brutal. Winding steps carved by forgotten hands led them deeper than they thought possible. Statues lined the path—kings with eyes missing, queens with mouths sewn shut.
Kalen muttered constantly, his voice a tremor. "We shouldn't be here. We shouldn't be here." Elira didn't reply. She focused on each step, on every creak of stone.
At the third descent, they passed a pit. Inside it lay bones—not broken, not decayed. Preserved. Sleeping. As if waiting for a signal.
The air grew warm, then hot, then unbearable. But still they walked. Something was calling. Something older than the kingdom. Something hungry.''',
              ),
              const Page(
                number: 3,
                content:
                    '''They found the chamber deep beneath the earth—a vault shaped like a heart. At its center stood a throne of black iron, untouched by time.
A sword lay embedded in stone before it, glowing faintly. Chains hung from the walls—broken.
Elira approached. The symbols pulsed under her feet. Kalen collapsed to his knees. "They freed it," he whispered. "We're too late."
Elira didn't speak. Her hand reached for the sword. It burned her skin, but she didn't let go.
Whatever had been imprisoned here… was awake. And it knew her name.''',
              ),
            ],
            isUnlocked: false,
            unlockCost: 150,
          ),
          Chapter(
            id: 5,
            title: 'Chapter 5: The Price of Fire',
            pages: [
              const Page(
                number: 1,
                content:
                    '''It rose from the shadows like a storm given form—crowned in fire, cloaked in smoke. Its face shifted endlessly: her father, her brother, her fears, her guilt. And beneath it all, something ancient. Something divine.
"You seek what is already broken," it said. "You dig up graves and dare name it love."
Elira did not flinch. She held her sword steady. "I seek truth."
It laughed. A thousand voices in one. "Truth is a weapon. And you are not ready to wield it."
Kalen screamed behind her. The creature turned. "He belongs to me now."
Elira moved.''',
              ),
              const Page(
                number: 2,
                content:
                    '''The fight was not a battle—it was a war of wills. Every step forward cost her a piece of herself. Every blow she struck echoed with memories—of firelight and lullabies, of blood and betrayal.
The sword in her hand grew heavy. The room bled light. And still she stood. For every lie the creature spoke, she answered with a memory. For every fear it conjured, she countered with defiance.
At last, the beast faltered. It roared. "You cannot kill what was never born."
"No," she said. "But I can end what should never wake."
And she drove the sword home.''',
              ),
              const Page(
                number: 3,
                content:
                    '''When she emerged from the mountain, dawn was breaking. Smoke curled behind her like a final breath. Her cloak was torn, her body broken, but her spirit burned like the rising sun.
Kalen leaned against her, still alive, still breathing. He would heal. So would she.
The world would not remember the battle. They would not sing songs of her victory. But it did not matter.
She had walked through fire and darkness, through gods and monsters, and she had returned with something greater than glory:
Her brother.
And the unyielding knowledge that some embers, no matter how faint, never truly die.''',
              ),
            ],
            isUnlocked: false,
            unlockCost: 200,
          ),
        ],
      );
      emit(BookLoaded(book));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }

  void _onUnlockChapter(UnlockChapter event, Emitter<BookState> emit) {
    if (state is BookLoaded) {
      final currentState = state as BookLoaded;
      final book = currentState.book;
      final chapterIndex = book.chapters.indexWhere(
        (c) => c.id == event.chapterId,
      );

      if (chapterIndex != -1) {
        final chapter = book.chapters[chapterIndex];
        if (!chapter.isUnlocked && book.coins >= chapter.unlockCost) {
          final updatedChapters = List<Chapter>.from(book.chapters);
          updatedChapters[chapterIndex] = chapter.copyWith(isUnlocked: true);

          final updatedBook = Book(
            title: book.title,
            chapters: updatedChapters,
            coins: book.coins - chapter.unlockCost,
          );

          emit(BookLoaded(updatedBook));
        }
      }
    }
  }
}
