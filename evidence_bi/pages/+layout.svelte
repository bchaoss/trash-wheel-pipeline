<script>
	import '@evidence-dev/tailwind/fonts.css';
	import '../app.css';
	import { EvidenceDefaultLayout } from '@evidence-dev/core-components';
	export let data;
</script>

<EvidenceDefaultLayout {data} hideSidebar=true hideBreadcrumbs=true githubRepo='https://github.com/bchaoss/trash-wheel-analysis' >
	<slot slot="content" />
</EvidenceDefaultLayout>