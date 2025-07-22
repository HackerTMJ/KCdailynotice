import Image from "next/image";
import "./globals.css";
export default function Home() {
  return (
    <div className="font-sans grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20">
             <div className="flex flex-stretch items-center gap-4 row-start-2">
        <Image
          className="dark:invert justify-self-center"
          src="/next.svg"
          alt="Next.js logo"
          width={180}
          height={38}
          priority
        />
        <div className="">
        <h1 className="text-2xl font-bold">Home Page</h1>
        <p className="text-lg">Welcome to my portfolio!</p>
        </div>
      </div>
    </div>
  );
}
