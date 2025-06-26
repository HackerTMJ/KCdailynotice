import { Button } from "@/components/ui/button"
import Link from "next/link"

export default function Home() {
  return (
    <div className="min-h-screen">
      {/* Hero Section */}
      <section className="bg-gradient-to-r from-kchs-primary to-kchs-navy text-white">
        <div className="container section-padding">
          <div className="text-center max-w-4xl mx-auto">
            <h1 className="text-5xl md:text-6xl font-bold mb-6">
              Kuen Cheng High School
            </h1>
            <p className="text-xl md:text-2xl mb-8 opacity-90">
              Excellence in Education, Character Building, and Innovation
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Button size="lg" className="bg-white text-kchs-primary hover:bg-gray-100">
                Latest Announcements
              </Button>
              <Button size="lg" variant="outline" className="border-white text-white hover:bg-white hover:text-kchs-primary">
                Daily Notice
              </Button>
            </div>
          </div>
        </div>
      </section>

      {/* Quick Links Section */}
      <section className="section-padding bg-gray-50">
        <div className="container">
          <h2 className="text-center mb-12">Quick Access</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <QuickLinkCard
              title="Announcements"
              description="Latest school news and updates"
              href="/announcements"
              icon="📢"
            />
            <QuickLinkCard
              title="Daily Notice"
              description="Today's schedule and reminders"
              href="/daily-notice"
              icon="📋"
            />
            <QuickLinkCard
              title="Events"
              description="Upcoming school events"
              href="/events"
              icon="📅"
            />
            <QuickLinkCard
              title="Gallery"
              description="School photos and memories"
              href="/gallery"
              icon="🖼️"
            />
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="section-padding">
        <div className="container">
          <div className="text-center mb-12">
            <h2 className="mb-4">Welcome to Our Digital Campus</h2>
            <p className="text-xl text-muted-foreground max-w-2xl mx-auto">
              Stay connected with our school community through our modern digital platform
            </p>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <FeatureCard
              title="Real-time Updates"
              description="Get instant notifications about school announcements, events, and important notices."
            />
            <FeatureCard
              title="Easy Navigation"
              description="Find what you need quickly with our intuitive design and organized content structure."
            />
            <FeatureCard
              title="Mobile Friendly"
              description="Access all school information on any device, anywhere, anytime."
            />
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-kchs-navy text-white section-padding">
        <div className="container">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div>
              <h3 className="text-xl font-bold mb-4">Contact Us</h3>
              <p className="mb-2">📍 School Address Here</p>
              <p className="mb-2">📞 +60-3-XXXX-XXXX</p>
              <p>✉️ info@kuencheng.edu.my</p>
            </div>
            <div>
              <h3 className="text-xl font-bold mb-4">Quick Links</h3>
              <ul className="space-y-2">
                <li><Link href="/staff" className="hover:text-kchs-accent transition-colors">Staff Directory</Link></li>
                <li><Link href="/downloads" className="hover:text-kchs-accent transition-colors">Downloads</Link></li>
                <li><Link href="/contact" className="hover:text-kchs-accent transition-colors">Contact</Link></li>
              </ul>
            </div>
            <div>
              <h3 className="text-xl font-bold mb-4">About</h3>
              <p className="text-sm opacity-90">
                Kuen Cheng High School is committed to providing quality education
                and fostering character development in our students.
              </p>
            </div>
          </div>
          <div className="border-t border-white/20 mt-8 pt-8 text-center">
            <p>&copy; 2025 Kuen Cheng High School. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </div>
  )
}

function QuickLinkCard({ title, description, href, icon }: {
  title: string
  description: string
  href: string
  icon: string
}) {
  return (
    <Link href={href}>
      <div className="bg-white p-6 rounded-lg card-shadow hover:scale-105 transition-transform duration-300 text-center h-full">
        <div className="text-4xl mb-4">{icon}</div>
        <h3 className="text-xl font-semibold mb-2">{title}</h3>
        <p className="text-muted-foreground">{description}</p>
      </div>
    </Link>
  )
}

function FeatureCard({ title, description }: {
  title: string
  description: string
}) {
  return (
    <div className="text-center">
      <h3 className="text-xl font-semibold mb-3">{title}</h3>
      <p className="text-muted-foreground">{description}</p>
    </div>
  )
}
