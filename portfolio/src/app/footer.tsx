import react from 'react';

export default function Footer() {
  return (
    <footer className="bg-gray-800 text-white p-4 text-center">
      <p className="text-sm">
        © {new Date().getFullYear()} My Portfolio. All rights reserved.
      </p>
      <p className="text-xs mt-2">
        Built with Next.js and Tailwind CSS.
      </p>
      <p>Follow me on 
                    <a href="https://github.com" className="text-blue-400 hover:underline"> GitHub</a> and 
                    <a href="https://twitter.com" className="text-blue-400 hover:underline"> Twitter</a>.
                </p>
    </footer>
  );
}