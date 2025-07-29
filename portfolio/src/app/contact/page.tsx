import react from 'react';
import { FaSquareXTwitter } from "react-icons/fa6";
import { FaBuilding } from "react-icons/fa6";
import { IoMdMail } from "react-icons/io";
import { FaPhone } from "react-icons/fa";
import { FaFacebook, FaInstagram } from "react-icons/fa";
export default function ContactPage() {
    return (
        <div className="min-h-screen m-10 p-10 bg-gray-100 rounded-lg shadow-lg">
            <div className="flex flex-col items-center justify-center min-h-screenp-4 float-left align-middle m-10">
                <h1 className="text-3xl font-bold">Contact Us</h1>
                <p className="mt-4">We would love to hear from you!
                     Please reach out with any questions or feedback.</p>
                <form className="mt-6 w-full max-w-md">
                    <div className="mb-4">
                        <label className="block text-sm font-medium text-gray-700" htmlFor="name">Name</label>
                        <input
                            type="text"
                            id="name"
                            className="mt-1 block w-full p-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500"
                            placeholder="Your Name"
                            required
                        />
                        <label className="block text-sm font-medium text-gray-700 mt-4" htmlFor="email">Email</label>
                        <input
                            type="email"
                            id="email"
                            className="mt-1 block w-full p-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500"
                            placeholder="Your Email"
                            required
                        />
                        <label className="block text-sm font-medium text-gray-700 mt-4" htmlFor="message">Message</label>
                        <textarea
                            id="message"
                            className="mt-1 block w-full p-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500"
                            placeholder="Your Message"
                            rows={4}
                            required
                        ></textarea>
                        <button type="submit" className="mt-6 w-full p-2 bg-blue-500 text-white rounded-md hover:bg-blue-600">
                            Send Message
                        </button>
                    </div>
                </form>
            </div>
            <div className='float-right flex flex-col min-w-100 items-center justify-center p-4 m-10 bg-black text-white  shadow-md'>
                <h1 className='text-xl font-bold'>Info</h1>
                <h2><a href="mailto:info@example.com"><span><IoMdMail/></span>info@example.com</a></h2>
                <h2 className='mt-2'><a href="tel:+1234567890"><span><FaPhone /></span>+1 (234) 567-890</a></h2>
                <h2 className='mt-2'><span><FaBuilding /> 123 Example Street, Suite 456</span></h2>

                <h2 className='mt-4'>Connect with us:</h2>
                <p className='mt-2'>Follow us on social media:</p>
                <div className='flex space-x-4 mt-2'>
                    <a href="https://twitter.com" className="text-blue-500 hover:underline"><FaSquareXTwitter />Twitter</a>
                    <a href="https://facebook.com" className="text-blue-500 hover:underline"><FaFacebook />Facebook</a>
                    <a href="https://instagram.com" className="text-blue-500 hover:underline"><FaInstagram />Instagram</a>
                </div>
            </div>
        </div>
    );}