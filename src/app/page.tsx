import { Metadata } from "next";

export const metadata: Metadata = {
	title: "Nextjs Starter Frontend",
	description: "Production grade Next.js starter template",
};

const page = () => {
	return (
		<section className="grid h-[90dvh] place-items-center">
			<div className="space-y-2 text-center">
				<h1 className="text-5xl font-semibold">nextjs-frontend-template</h1>
				<h2 className="text-3xl">
					A production-ready Next.js starter for building modern, scalable
					frontends
				</h2>
			</div>
		</section>
	);
};

export default page;
