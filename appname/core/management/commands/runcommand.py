from django.core import management
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    help = "for testing command"

    def handle(self, *args, **options):
        import posthog
        
        # Test 1: Basic capture
        try:
            posthog.capture(
                distinct_id='test-id-123',
                event='command_test_event',
                properties={
                    'command_name': 'runcommand',
                    'status': 'started',
                    'environment': 'development'
                }
            )
            self.stdout.write(self.style.SUCCESS('✅ Basic event sent successfully'))
        except Exception as e:
            self.stdout.write(self.style.ERROR(f'❌ Basic event failed: {e}'))

        # Test 2: With context
        try:
            with posthog.new_context():
                posthog.identify('test-user-456', {
                    'email': 'test@example.com',
                    'name': 'Test User'
                })
                posthog.capture(
                    distinct_id='test-user-456',
                    event='context_test_event',
                    properties={
                        'command_name': 'runcommand',
                        'status': 'processed',
                        'timestamp': '2025-08-07T17:00:00Z'
                    }
                )
            self.stdout.write(self.style.SUCCESS('✅ Context event sent successfully'))
        except Exception as e:
            self.stdout.write(self.style.ERROR(f'❌ Context event failed: {e}'))

        # Test 3: Error tracking
        try:
            posthog.capture(
                distinct_id='test-system',
                event='system_error',
                properties={
                    'error_type': 'test_error',
                    'error_message': 'This is a test error',
                    'severity': 'low',
                    'component': 'management_command'
                }
            )
            self.stdout.write(self.style.SUCCESS('✅ Error event sent successfully'))
        except Exception as e:
            self.stdout.write(self.style.ERROR(f'❌ Error event failed: {e}'))

        self.stdout.write(self.style.SUCCESS('🎯 All PostHog tests completed!'))
