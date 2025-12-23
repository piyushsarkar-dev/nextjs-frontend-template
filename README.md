# Next.js Frontend Template

![Project Preview](./public/preview.png)

Hi there! 👋 Welcome to your new favorite starting point for Next.js projects.

This isn't just another boilerplate—it's a carefully crafted, production-ready template designed to let you hit the ground running. Whether you're building a SaaS product, a portfolio, or a complex web application, this starter kit handles the boring setup so you can focus on building what matters.

Built with the bleeding-edge tech stack you actually want to use: **Next.js 16**, **React 19**, **Tailwind CSS 4**, and **Shadcn UI**.

## ✨ Why this template?

We've all been there—spending hours configuring ESLint, setting up dark mode, or fighting with Tailwind configs before writing a single line of feature code. This template solves that. It comes pre-configured with best practices, type safety, and a beautiful UI library, so you can start shipping features on Day 1.

### 🚀 Features at a Glance

- **Next.js 16 (App Router)**: The latest and greatest from Vercel, optimized for performance.
- **React 19**: Ready for the future of React.
- **Tailwind CSS 4**: The newest, fastest version of the utility-first framework.
- **Shadcn UI**: Beautiful, accessible components that you can actually customize.
- **Dark Mode Ready**: Built-in theme switching with `next-themes`.
- **Type-Safe**: 100% TypeScript for fewer bugs and better autocomplete.
- **Linting & Formatting**: ESLint and Prettier are already set up to keep your code clean.

## 🛠️ Tech Stack

- **Framework**: [Next.js](https://nextjs.org/)
- **UI Library**: [React](https://react.dev/)
- **Styling**: [Tailwind CSS](https://tailwindcss.com/)
- **Components**: [Shadcn UI](https://ui.shadcn.com/)
- **Icons**: [Lucide React](https://lucide.dev/)
- **Package Manager**: npm or Bun

## ⚡ Quick Start

Getting started is super easy. You can use either `npm` or `Bun`.

### 1. Clone the repo

```bash
git clone https://github.com/piyushsarkar-dev/nextjs-frontend-template.git
cd nextjs-frontend-template
```

### 2. Install dependencies

Pick your fighter:

**Using npm:**

```bash
npm install
```

**Using Bun (Recommended for speed):**

```bash
bun install
```

### 3. Run the development server

**npm:**

```bash
npm run dev
```

**Bun:**

```bash
bun dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser, and you're live! 🚀

## 🔧 Customization

Make it yours! Here are a few things you might want to update in `package.json`:

- **name**: Change `nextjs-frontend-template` to your project name.
- **author**: Update `Piyush Sarkar` to your name.
- **homepage**: Point this to your own repository.

## 📂 Project Structure

Here's how we've organized things to keep it clean and scalable:

```
├── public/              # Static assets (images, fonts, etc.)
├── src/
│   ├── app/             # Main application routes (App Router)
│   ├── components/      # Your UI building blocks
│   │   ├── Header/      # Navigation components
│   │   ├── Providers/   # App-wide providers (Theme, Context)
│   │   └── shadcnui/    # The beautiful Shadcn components
│   ├── hooks/           # Custom React hooks
│   └── lib/             # Utility functions (cn, etc.)
├── next.config.ts       # Next.js configuration
└── package.json         # Dependencies and scripts
```

## 📜 Scripts

- `dev`: Spin up the dev server.
- `build`: Compile for production.
- `start`: Run the production build locally.
- `lint`: Check your code for style issues.

## 👤 Author

**Piyush Sarkar**

- GitHub: [@piyushsarkar-dev](https://github.com/piyushsarkar-dev)

---

_Happy Coding!_ 💻
