import { useParams, Link } from 'react-router-dom';
import { ArrowRight } from 'lucide-react';

export default function InformationPage() {
  const { slug } = useParams();

  const pages = {
    'contact-us': [
      'We’re here to help.',
      'For order, product or delivery questions, write to us at support@dailyobjects.example. Please include your order number if you have one.'
    ],
    shipping: [
      'Shipping & Delivery Policy',
      'All domestic orders above ₹1,499 receive complimentary express shipping. Standard delivery takes 2–4 business days depending on your postal code.'
    ],
    returns: [
      'Easy Returns & Exchanges',
      'We offer a 7-day hassle-free return window for all unused carry pieces in original packaging. Contact support to initiate a return pickup.'
    ],
    faqs: [
      'Frequently Asked Questions',
      'How can I track my order? Sign in to your account and open My Orders. Are your bags water-resistant? Yes, our premium canvas and technical fabrics feature a water-repellent coating.'
    ],
    'about-us': [
      'Objects for Life in Motion.',
      'Daily Objects creates thoughtful carry essentials for work, travel, and everything in between. We believe useful things can be beautifully considered.'
    ],
    'privacy-policy': [
      'Privacy Policy',
      'We respect your privacy. Customer information is securely encrypted and used strictly for order fulfillment and account maintenance.'
    ],
    'terms-and-conditions': [
      'Terms & Conditions',
      'All product pricing and availability are updated in real-time. Orders are officially confirmed upon server verification of payment.'
    ]
  };

  const [title, copy] = pages[slug] || [
    'Information',
    'This page is being updated. Contact support@dailyobjects.example for help.'
  ];

  return (
    <main className="page information-page" style={{ paddingTop: '24px' }}>
      <span className="eyebrow">DAILY OBJECTS · CUSTOMER CARE</span>
      <h1>{title}</h1>
      <p>{copy}</p>

      {slug === 'contact-us' && (
        <a className="button button-dark" href="mailto:support@dailyobjects.example">
          Email Customer Care <ArrowRight size={16} />
        </a>
      )}

      <div style={{ marginTop: '24px' }}>
        <Link className="text-link" to="/shop">
          Continue shopping <ArrowRight size={16} />
        </Link>
      </div>
    </main>
  );
}
