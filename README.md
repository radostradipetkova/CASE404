# CASE 404 — Digital Forensics System

**[Play the live detective game](https://case-404.radostradi-pogo.workers.dev/)** · [Cloudflare Worker API](https://case-404.radostradi-pogo.workers.dev/api/health)


A portfolio-ready, original interactive detective investigation using **vanilla HTML/CSS/JS**, **Cloudflare Workers**, and **Cloudflare D1 (SQLite)**. No paid APIs or backend accounts.

## Project structure

```
CASE404/
├── public/
│   ├── index.html          # responsive dashboard shell
│   ├── style.css           # dark investigation design
│   └── app.js              # navigation, puzzles, board, notes, endings
├── src/
│   └── worker.js           # validated read-only D1 API
├── migrations/
│   └── 0001_initial.sql    # eight database tables and indexes
├── scripts/
│   └── seed.sql            # original case, clues and transcripts
├── wrangler.toml           # Worker, static assets and D1 binding
├── package.json
└── README.md
```

## Setup and local development

Prerequisites: Node.js 20+ and a free Cloudflare account. Install dependencies:

```bash
npm install
npx wrangler login
npx wrangler d1 create case404
```

Copy the `database_id` returned by the create command into `wrangler.toml`, replacing `REPLACE_WITH_YOUR_D1_DATABASE_ID`.

```bash
npm run db:migrate:local
npm run db:seed:local
npm run dev
```

Open the localhost URL Wrangler prints (typically http://localhost:8787). The Worker serves static assets and API endpoints. You cannot run `index.html` directly using `file://` because it relies on the D1-backed Worker API.

## Deploy to Cloudflare

```bash
npm run db:migrate:remote
npm run db:seed:remote
npm run deploy
```

Wrangler prints the live `workers.dev` URL. For the free tier, D1 and Worker limits depend on Cloudflare's current published quotas; check the dashboard before using production traffic. No secrets are required for the demo.

## Public API

All endpoints accept GET only. No public mutation routes exist.

| Endpoint | Description |
|---|---|
| `/api/health` | Worker and configuration health |
| `/api/case` | Case overview |
| `/api/suspects` | Suspects; optional `q`, `filter=high\|medium\|low` |
| `/api/suspects/s1` | Individual suspect (s1–s4) |
| `/api/evidence` | Evidence; optional `q`, `filter=Digital` etc. |
| `/api/interviews` | Interview transcripts; optional `q` |
| `/api/messages` | SMS and email; optional `q`, `filter=sms\|email` |
| `/api/timeline` | Timeline; optional `q` |

Queries use **parameterized D1 prepared statements**; table names and searchable fields come from fixed server-side allowlists. Search input is trimmed and length-limited. All rendered dynamic content is HTML-escaped. The browser stores private notes, evidence selections, solved puzzles and outcomes in `localStorage` under `case404:local:v1`. These are **per-browser**, not synchronized or securely authenticated. Clearing site data removes them.

### Demo security / limitations

The D1 schema includes `detective_notes` and `investigation_progress` to demonstrate the complete domain model, but **these tables are intentionally unused by the public API**. Without authentication, exposing their CRUD operations would leak or overwrite users' private data. Notes CRUD is implemented in the browser, including create, read, edit and delete. This is not an account-based case-management product. Case records are public fictional data; the API can return locked evidence because puzzle locking is a **game mechanic**, not a confidentiality boundary. Do not place actual secrets in seed data. Client-side progress and outcomes can be edited by the player through developer tools; this is acceptable for a single-player demo.

## Mystery logic and proof

1. Noah's switch maintenance is verified independently at 21:55–22:27; his access alone does not prove he used the camera control token.
2. Iris is independently filmed at the café at 22:24, and Elena's continuous video meeting is verified at 21:31–22:32.
3. Adrian's claimed continuous gate watch is contradicted by the final 22:02 camera still.
4. The recovered 22:14 command ties the blackout to SEC-03 and Adrian's assigned physical token.
5. Mara's 22:09 draft names Adrian and reports a cloned badge. The 22:19 badge exit uses manual override and cannot prove her physical exit.
6. The 22:17 mechanical stairwell event and locker 27 note explain how Mara escaped without a badge. Adrian is responsible for the cover-up; the story does **not** imply that disappearance proves murder.

The three puzzles use chronological ordering, a preserved mail-cache timestamp, and the logical distinction between a credential event and a person's location. Each unlocks additional evidence. A correct, fully supported ending requires accusing Adrian **and** collecting e6, e7, e8 after solving all three puzzles. Early accusations produce an inconclusive outcome; incorrect accusations produce a wrongful-accusation ending. Players can retry, and past decisions remain in local history.

## Quick smoke test

1. Open Overview, then Suspects; search `Adrian` and filter `high`.
2. Collect evidence e1–e5; open Board and link any two.
3. Visit Decryptions; solve puzzle 1 with `21:55 → 22:02 → 22:14`, puzzle 2 with `22:09`, puzzle 3 with `The badge event cannot prove Mara’s whereabouts`.
4. Collect e6, e7 and e8; check recovered messages and timeline events.
5. Create, edit and delete a note; refresh to verify local persistence.
6. Accuse Adrian to reach the supported ending. Try another suspect to see the alternate outcome.
7. Use Reset to delete browser-local progress; D1 data stays unchanged.

## Version 2 — Immersive investigation interface

This edition adds a draggable evidence board with SVG relationship lines, browser-persisted card positions, a reconstructed smartphone with selectable SMS conversations, a three-pane recovered email interface, illustrated suspect dossier portraits, an interactive chronological-event reconstruction, timestamp-entry recovery, a contradiction-analysis challenge, and a five-stage onboarding walkthrough. The underlying read-only D1 API, migration, seed records, note CRUD, and browser-local progress model are unchanged. The portraits and evidence thumbnails are original CSS illustrations, **not photographic records**.

### Updating an existing local installation

Back up your current project, then replace the `public/app.js` and `public/style.css` files with the ones from this ZIP. You may replace the full source tree if you preserve your own `wrangler.toml` database ID. No new migrations are required. In your existing terminal stop the server with Ctrl+C and restart using `npm.cmd run dev`. Reload the browser with Ctrl+Shift+R. Your progress is stored in localStorage under `case404:local:v1` and remains available when using the same browser and origin. The tutorial appears for browsers that have not completed it, and can be replayed from the overview.

### Known limits

The phone and email clients are fictional, read-only forensic reconstructions and do not send messages. Board connections are user-created associations rather than server-verified causal relationships. Illustrations are deliberately stylized rather than photorealistic. LocalStorage progress does not synchronize across devices.