import { Github } from "lucide-react";
import Image from "next/image";
import Link from "next/link";
import ThemeToggleButton from "../ThemeToggleButton";

const Header = () => {
	return (
		<header
			className="fixed right-0 left-0 border-b shadow"
			aria-label="app-header">
			<div className="mx-auto flex max-w-7xl items-center justify-between px-6 py-3">
				<Link
					href={"/"}
					className="flex items-center gap-2">
					<Image
						src="/logo.png"
						alt="Logo"
						width={62}
						height={62}
						className="object-contain"
					/>
					<h1
						className="text-2xl font-semibold"
						aria-label="App Name">
						NEXT App
					</h1>
				</Link>

				<nav className="flex items-center gap-4">
					<Link href={"/"}>Home</Link>
					<Link
						href={"https://github.com/piyushsarkar-dev"}
						target="_blank"
						rel="noopener noreferrer">
						<Github />
					</Link>
					<ThemeToggleButton />
				</nav>
			</div>
		</header>
	);
};

export default Header;
