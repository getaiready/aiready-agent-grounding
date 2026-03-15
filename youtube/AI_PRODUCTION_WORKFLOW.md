# Master Workflow: Fully AI-Generated Video Production

To achieve a 14-day daily release cycle for **The OpenClaw Revolution** without burning out, we will utilize a "Digital Twin" pipeline. This allows you to provide the **Architecture** while the AI handles the **Performance**.

## The "SuperPeng" AI Stack

| Layer                 | Tool              | Purpose                                                                                                                                           |
| :-------------------- | :---------------- | :------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Identity**          | **HeyGen**        | Creates a "Digital Twin" of SuperPeng. You film yourself once (2 mins), and the AI generates all future footage of you speaking from our scripts. |
| **Voice**             | **ElevenLabs**    | Clones your voice with perfect emotional inflection and multi-language support (English/Chinese).                                                 |
| **B-Roll (Motion)**   | **Runway Gen-3**  | Turns our branding images and storyboard concepts into cinematic, moving video clips.                                                             |
| **Technical Visuals** | **Screen Studio** | (Manual but fast) High-end screen recordings of OpenClaw in action, enhanced with automatic zooms.                                                |
| **Assembly**          | **Descript**      | The "Engine Room." You edit the video by editing the text. It automatically syncs your avatar, voice, and B-roll.                                 |

---

## The Daily Production Loop

### Step 1: Script & Guide Generation (Done by Antigravity)

We continue drafting the `script.md` and `production-guide.md` for each day. These are optimized for **NotebookLM** to ingest.

### Step 2: Voice & Avatar Generation

1.  Paste the script into **ElevenLabs**. Download the master VO.
2.  Upload the VO to **HeyGen** along with your Digital Twin template.
3.  HeyGen generates the "Talking Head" clips for the Intro, Transitions, and Outro.

### Step 3: Generative B-Roll

1.  Take the visual assets from `youtube/assets/branding/`.
2.  Input them into **Runway** with a "Motion Brush" to animate the data pulses, logic bricks, or world maps.

### Step 4: The Descript "Snap-to-Grid"

1.  Import the HeyGen clips and ElevenLabs VO into **Descript**.
2.  Use the `script.md` as the transcript.
3.  Drag and drop the animated B-roll and screen recordings over the corresponding text markers.
4.  Apply "Studio Sound" to make the AI voice sound like it was recorded in a professional booth.

---

## Why This Wins

- **Time**: Each episode takes ~1-2 hours to assemble instead of 10+ hours of filming/editing.
- **Consistency**: The lighting, audio, and branding are identical across all 14 days.
- **Global Reach**: We can instantly generate a Chinese version (超级大鹏) by simply translating the script and clicking "Generate" in ElevenLabs.

---

## Instructions for Antigravity (Me)

Going forward, I will format all storyboards with **[CAM]** marks for HeyGen segments and **[TECH]** marks for screen/gen-video segments to make your assembly even easier.
